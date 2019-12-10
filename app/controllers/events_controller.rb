class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    @events = Event.where(validated: true);
  end

  def show
  	@event = Event.find(params[:id])
    @count = @event.attendances.count
    @admin_email = @event.admin.email
    @attendances = @event.attendances
    @attendee = @attendances.find_by(attendee: current_user.id)
  end

  def new
    @events = Event.all
    @locations = @events.collect{ |event| event.location }
  end

  def create
  	event = Event.new(
  												start_date: params[:event][:start_date],
  												duration: params[:event][:duration],
  												title: params[:title],
  												description: params[:description],
  												price: params[:event][:price],
  												location: params[:location],
  												admin_id: current_user.id
  											)
  	if event.save
  		flash[:success] = "Evenement cree avec succes"
  		redirect_to event_path(event.id)
  	else
  		render :new
  		flash.now[:danger] = "#{event.errors.messages}"
  	end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(
                      title: params[:event][:title],
                      start_date: params[:event][:start_date],
                      duration: params[:event][:duration],
                      title: params[:event][:title],
                      description: params[:event][:description],
                      price: params[:event][:price],
                      location: params[:event][:location]
                    )
      flash[:success] = "Evenement modifie avec success"
      redirect_to event_path(@event.id)
    else
      render :edit
      flash.now[:danger] = "#{@event.errors.messages}"
    end
  end

  def destroy
    event = Event.find(params[:id])
    if event.destroy
      flash[:success] = "Evenement supprime avec succes"
      redirect_to root_path
    end
  end

  # private def params permit...
end