class SuperAdmin::EventSubmissionsController < ApplicationController
  def index
  	@events_to_valid = Event.where(validated: nil);
    @validated_events = Event.where(validated: true);
  end

  def show
  	@event_to_valid = Event.find(params[:id])
  end

  def edit
    @event_to_valid = Event.find(params[:id])
    puts "@" * 89
    puts params
  end

  def update
    @event = Event.find(params[:id])
    @valid = 
      params[:event][:validated] == 'yes' ? true : false
    if @event.update(validated: @valid)
      flash[:success] = "The event is validated"
      redirect_to super_admin_event_submissions_path
    else
      flash.now[:danger] = "#{@event.errors.messages}"
      render :edit
    end

  end
end
