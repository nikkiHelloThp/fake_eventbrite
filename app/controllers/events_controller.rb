class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.validated
  end

  def show
    @count = @event.attendances.count
    @admin_email = @event.admin.email
    @attendee = @event.attendances.find_by(attendee: current_user.id)
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    event.admin = current_user
  	if event.save
  		flash[:success] = "Evenement cree avec succes"
  		redirect_to event
  	else
  		render :new
  		flash.now[:danger] = "#{event.errors.full_messages}"
  	end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = "Evenement modifie avec success"
      redirect_to @event
    else
      render :edit
      flash.now[:danger] = "#{@event.errors.full_messages}"
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = "Evenement supprime avec succes"
      redirect_to root_path
    end
  end

  
  private

  def set_event 
    @event ||= Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location)
  end

end