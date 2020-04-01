class SuperAdmin::ApplicationController < ApplicationController
	before_action :check_if_super_admin

  def check_if_super_admin
		if current_user.is_super_admin
  		@admin = current_user
  	else
  		flash[:danger] = "You have no access to the admin dashboard"
  		redirect_to root_path
  	end
	end
end