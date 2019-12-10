require_relative '../services/charge'

class AttendancesController < ApplicationController
  before_action :is_admin_of_event?, only: [:index]

  def index
  	@event = Event.find(params[:event_id])
  	@attendances = @event.attendances
  end

  def new
    @event = Event.find(params[:event_id])
    @amount = @event.price
    @amount_in_cent = @amount * 100
  end

  def create
    @event = Event.find(params[:event_id])
    unless @event.is_free?
      params[:amount_in_cent] = @event.price * 100
      charge = Charge.new.perform(params)
      attendance = Attendance.new(
                                   stripe_customer_id: charge.customer,
                                   attendee_id: current_user.id,
                                   event_id: params[:event_id]
                                 )
      if attendance.save
        flash[:success] = "Vous participez a l'evenement"
        redirect_to event_path(@event.id)
      else
        flash[:danger] = "#{attendance.errors.messages}"
        render :new
      end
    else
      attendance = Attendance.new(
                                      attendee_id: current_user.id,
                                      event_id: params[:event_id]
                                    )
      if attendance.save
        flash[:success] = "Vous participez a l'evenement"
        redirect_to event_path(@event.id)
      else
        flash[:danger] = "#{attendance.errors.messages}"
        render :new
      end
    end
  end

  def is_admin_of_event?
    @event = Event.find(params[:event_id])
    unless current_user == @event.admin
      flash[:danger] = "Vous n'etes pas admin de cet evenement!"
      redirect_to root_path
    end
  end

  # penser a refacto: Event.find(params[:event_id])   il est present partout!
end
