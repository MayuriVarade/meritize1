class VoteSetting < ActiveRecord::Base
  attr_accessible :award_frequency_type, :award_program_name, :end_cycle, :intro_text, :start_cycle,:user_id,:email_sender_name,:email_sender_email,:email_sender_subject1,:email_sender_body1,:email_sender_subject2,:email_sender_body2,:email_sender_subject3,:email_sender_body3
  has_many :vote_cycles
  has_many :nominee
  
end
