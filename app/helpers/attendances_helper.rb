module AttendancesHelper

	def is_event_admin?
    unless current_user == @event.admin
      flash[:danger] = "Vous n'etes pas admin de cet evenement!"
      redirect_to root_path
    end
  end
end
