class SuperAdmin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @is_super_admin = [false, true]
    @random_user = rand(1..9999)
  end

  def create
    user = User.new(
                     description: params[:description],
                     f_name: params[:f_name],
                     l_name: params[:l_name],
                     email: params[:email],
                     password: params[:password],
                     is_super_admin: params[:is_super_admin]
                   )
    if user.save
      # probleme: flash arrive sur la meme ligne que le 1er element
      flash[:success] = "User created"
      redirect_to super_admin_users_path
    else
      flash.now[:danger] = "#{user.errors.messages}"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    @is_super_admin = [false, true]
  end

  def update
# METHODE A REFACTO CAR C'EST BIEN DEGEU
    @user = User.find(params[:id])

    if params[:user][:description] != ""
      @user.description = params[:user][:description]
    end
    if params[:user][:f_name] != ""
      @user.f_name = params[:user][:f_name]
    end
    if params[:user][:l_name] != ""
      @user.l_name = params[:user][:l_name]
    end
    if params[:user][:email] != ""
      @user.email = params[:user][:email]
    end
    if params[:user][:password] != ""
      @user.password = params[:user][:password]
    end
    if params[:user][:is_super_admin] != "false"
      @user.is_super_admin = params[:user][:is_super_admin]
    end
    if @user.save
      flash[:success] = "User updated"
      redirect_to super_admin_users_path
    else
      flash.now[:danger] = "#{@user.errors.messages}"
      render :edit
    end

  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:success] = "User deleted"
      redirect_to super_admin_users_path
    else
      flash.now[:danger] = "#{user.errors.messages}"
    end
  end

end
