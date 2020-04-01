class SuperAdmin::UsersController < SuperAdmin::ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = "User created"
      redirect_to super_admin_users_path
    else
      flash.now[:danger] = "#{user.errors.full_messages}"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User updated"
      redirect_to super_admin_users_path
    else
      flash.now[:danger] = "#{@user.errors.full_messages}"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted"
      redirect_to super_admin_users_path
    else
      flash.now[:danger] = "#{@user.errors.full_messages}"
    end
  end


  private

  def set_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:f_name, :l_name, :description, :email, :password, :is_super_admin)
  end
end
