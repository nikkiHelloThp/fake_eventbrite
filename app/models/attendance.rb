class Attendance < ApplicationRecord
	after_create :send_feedback_to_admin

	belongs_to :attendee, class_name: "User"
	belongs_to :event

	def send_feedback_to_admin
		AttendanceMailer.feedback_email(self).deliver_now
	end
		
end
