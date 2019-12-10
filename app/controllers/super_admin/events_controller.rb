class SuperAdmin::EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
  end

  def create
    event = Event.new(
                       start_date: params[:event][:start_date],
                       duration: params[:event][:duration],
                       title: params[:title],
                       description: params[:description],
                       price: params[:event][:price],
                       location: params[:location],
                       admin_id: current_user.id,
                       validated: true
                     )
    if event.save
      flash[:success] = "Event created"
      redirect_to super_admin_events_path
    else
      flash.now[:danger] = "#{event.errors.messages}"
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(
                       start_date: params[:event][:start_date],
                       duration: params[:event][:duration],
                       title: params[:title],
                       description: params[:description],
                       price: params[:event][:price],
                       location: params[:location]
                    )
      flash[:success] = "Event updated"
      redirect_to super_admin_events_path
    else
      flash.now[:danger] = "#{@event.errors.messages}"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:danger] = "Event destroyed"
      redirect_to super_admin_events_path
    end
  end
end
