class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
	after_create :send_welcome_email

	has_many :administred_events, foreign_key: 'admin_id', class_name: "Event"
	has_many :attendee_attendances, foreign_key: 'attendee_id', class_name: "Attendance"
	
	has_many :attendances
	has_many :events, through: :attendances

	has_one_attached :avatar

	def send_welcome_email
		UserMailer.welcome_email(self).deliver_now
	end		

end
