class PropMailer < ActionMailer::Base

	default :from => "support@imeritize.com"

  def prop_mail(user,prop)
  	@user = user
  	@prop = prop
    mail :to => user.email, :subject => prop.subject
  end

  def prop_mail_reminder2(user,prop)
  	@user = user
  	@prop = prop
    mail :to => user.email, :subject => prop.subject2
  end

  def prop_mail_reminder3(user,prop)
  	@user = user
  	@prop = prop
    mail :to => user.email, :subject => prop.subject3
  end
  def prop_notification_email(prop_display)
    
    @prop = prop_display
    mail :to => @prop.receiver.email, :subject => "Props to you!"
  end


end
