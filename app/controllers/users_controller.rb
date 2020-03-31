class UsersController < ApplicationController
	before_action :authenticate_user!
  before_action :set_user
	before_action :is_user_legit?

  def show
  	@events = Event.where(admin: @user);
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end


  private

  def set_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:f_name, :l_name, :description)
  end

  def is_user_legit?
		unless current_user == @user
			redirect_to user_path(current_user.id)
		end
  end
end
