class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :is_user_legit?, only: [:show]

  def show
  	@user = User.find(params[:id])
  	@events = Event.where(admin: @user);
  end

  def is_user_legit?
  	@user = User.find(params[:id])
		unless current_user == @user
			redirect_to user_path(current_user.id)
		end
  end
end
