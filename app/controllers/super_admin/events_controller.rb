class SuperAdmin::EventsController < SuperAdmin::ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    event.admin = current_user
    event.validated = true
    if event.save
      flash[:success] = "Event created"
      redirect_to super_admin_events_path
    else
      flash.now[:danger] = "#{event.errors.full_messages}"
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = "Event updated"
      redirect_to super_admin_events_path
    else
      flash.now[:danger] = "#{@event.errors.full_messages}"
      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:danger] = "Event destroyed"
      redirect_to super_admin_events_path
    end
  end


  private

  def set_event
    @event ||= Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
