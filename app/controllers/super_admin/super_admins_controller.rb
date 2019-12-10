class SuperAdmin::SuperAdminsController < ApplicationController
	before_action :check_if_super_admin

  def index
  end


  private

  def check_if_super_admin
		 if current_user
  		@admin = current_user if current_user.is_super_admin == true
  	end
	end
end
