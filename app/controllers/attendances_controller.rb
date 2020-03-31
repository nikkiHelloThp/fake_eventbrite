require_relative '../services/charge'

class AttendancesController < ApplicationController
  before_action :get_event
  before_action :is_admin_of_event?, only: [:index]

  def index
  	@attendances = @event.attendances
  end

  def new
    @amount = @event.price
    @amount_in_cent = @amount * 100
  end

  def create
    attendance = @event.attendances.build(attendee_id: current_user.id)

    if !@event.is_free?
      params[:amount_in_cent] = @event.price * 100
      charge = Charge.new.perform(params)
      attendance.stripe_customer_id = charge.customer
    end
    
    if attendance.save
      flash[:success] = "Vous participez a l'evenement"
      redirect_to @event
    else
      flash[:danger] = "#{attendance.errors.messages}"
      render :new
    end
  end

  def is_admin_of_event?
    unless current_user == @event.admin
      flash[:danger] = "Vous n'etes pas admin de cet evenement!"
      redirect_to root_path
    end
  end


  private

  def get_event
    @event ||= Event.find(params[:event_id])
  end
end
