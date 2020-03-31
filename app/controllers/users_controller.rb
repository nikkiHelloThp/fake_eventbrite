class UsersController < ApplicationController
	before_action :authenticate_user!
  before_action :set_user
	before_action :is_user_legit?, only: [:show]

  def show
  	@events = Event.where(admin: @user);
  end


  private

  def set_user
    @user ||= User.find(params[:id])
  end

  def is_user_legit?
		unless current_user == @user
			redirect_to user_path(current_user.id)
		end
  end
end
