class VoteMailer < ActionMailer::Base
  # default from: "from@example.com"

  def vote_mail(user,vote_setting)
  	@user = user
  	@vote_setting = vote_setting
    mail :from => vote_setting.email_sender_email,:to => user.email, :subject => vote_setting.email_sender_subject1
  end

  def vote_mail_reminder2(user,vote_setting)
  	@user = user
  	@vote_setting = vote_setting
    mail :from => vote_setting.email_sender_email,:to => user.email, :subject => vote_setting.email_sender_subject2
  end

  def vote_mail_reminder3(user,vote_setting)
  	@user = user
  	@vote_setting = vote_setting
    mail :from => vote_setting.email_sender_email,:to => user.email, :subject => vote_setting.email_sender_subject3
  end
end
