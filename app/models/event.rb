class Event < ApplicationRecord

	after_update :send_event_validated_email

	belongs_to :admin, class_name: "User"

	has_many :attendances
	has_many :admins, through: :attendances

	has_one_attached :photo

	validates_presence_of :start_date, :duration, :location

	validate :start_date_cannot_be_in_the_past

	validate :duration_must_be_a_multiple_of_5

	validates :title,
		presence: true,
		length: { in: 5..140 }

	validates :description,
		presence: true,
		length: { in: 20..1000 }

	validates :price,
		presence: true,
		length: { maximum: 1000 } 


	def start_date_cannot_be_in_the_past
		unless start_date > DateTime.now
			errors.add(:start_date, "can't be in the past")
		end
	end

	def duration_must_be_a_multiple_of_5
		unless duration % 5 == 0
			errors.add(:duration, "must be a multiple of 5")
		end
	end

	def end_date
		start_date + duration.minutes
	end

	def is_free?
		self.price == 0
	end

	def send_event_validated_email
		if self.validated != nil && self.validated_changed?
			EventMailer.event_validated_email(self).deliver_now
		end
	end

end
