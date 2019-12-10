class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@monsite.com'
  
  def welcome_email(user)
  	@user = user
  	@url = 'http://monsite.fr/login'
  	mail(to: @user.email, subject: 'Bienvenue chez nous!')
  end

  def feedback_email(attendance)
    @attendance = attendance
  	@admin = @attendance.event.admin
    @attendee = @attendance.attendee
  	@url = 'http://monsite.fr/login'
  	mail(to:@admin.email, subject: 'Un utilisateur a rejoint votre evenement!')
  end

  def event_validated_email(event)
    @event = event
    @admin = @event.admin
    @status = 
      @event.validated == true ? 'accepté' : 'refusé' 
    @url = 'http://monsite.fr/login'
    mail(to:@admin.email, subject: "Votre evenement a été #{@status}...")
  end
end
