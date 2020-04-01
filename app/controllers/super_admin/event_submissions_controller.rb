class SuperAdmin::EventSubmissionsController < SuperAdmin::ApplicationController
  before_action :set_event, only: %i[show edit update]

  def index
  	@events_to_valid = Event.to_valid
    @validated_events = Event.validated
  end

  def show
  	@event_to_valid = @event
  end

  def edit
  end

  def update
    @valid = 
      params[:event][:validated] == 'yes' ? true : false
    if @event.update(validated: @valid)
      flash[:success] = "The event is validated"
      redirect_to super_admin_event_submissions_path
    else
      flash.now[:danger] = "#{@event.errors.full_messages}"
      render :edit
    end

  end


  private

  def set_event
    @event ||= Event.find(params[:id])
  end
end
