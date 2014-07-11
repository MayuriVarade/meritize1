class PropMailer < ActionMailer::Base

	default :from => "Meritize <support@imeritize.com>"

  def prop_mail(user,prop)
  	@user = user
  	@prop = prop
    puts "Mail to: " + user.email
    puts "Mail subject: " + prop.subject
    puts "Mail from: " + prop.name
    puts "Mail email:" + prop.email
    mail :to => user.email, :subject => prop.subject, :from => prop.name + '<' + prop.email + '>'
  end

  def prop_mail_reminder2(user,prop)
  	@user = user
  	@prop = prop
    puts "Mail to: " + user.email
    puts "Mail subject: " + prop.subject
    puts "Mail from: " + prop.name
    puts "Mail email:" + prop.email
    mail :to => user.email, :subject => prop.subject2, :from => prop.name + '<' + prop.email + '>'
  end

  def prop_mail_reminder3(user,prop)
  	@user = user
  	@prop = prop
    mail :to => user.email, :subject => prop.subject3, :from => prop.name + '<' + prop.email + '>'
  end
  def prop_notification_email(prop_display)
    
    @prop = prop_display
    mail :to => @prop.receiver.email, :subject => "Props to you!"
  end


end
