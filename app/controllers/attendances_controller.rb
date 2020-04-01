require_relative '../services/charge'

class AttendancesController < ApplicationController
  include AttendancesHelper
  
  before_action :get_event
  before_action :is_event_admin?, only: [:index]

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
      flash[:danger] = "#{attendance.errors.full_messages}"
      render :new
    end
  end


  private

  def get_event
    @event ||= Event.find(params[:event_id])
  end
end
