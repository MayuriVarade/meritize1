class VoteSetting < ActiveRecord::Base
  attr_accessible :award_frequency_type, :award_program_name, :end_cycle, :intro_text, 
                  :start_cycle,:user_id,:email_sender_name,:email_sender_email,:email_sender_subject1,
                  :email_sender_body1,:email_sender_subject2,:email_sender_body2,:email_sender_subject3,
                  :email_sender_body3,:is_autopick_winner, :is_admin_reminder, :is_allow_vote,:reminder1_days,:reminder2_days,:reminder3_days
  has_many :vote_cycles
  has_many :nominee
  
  belongs_to :user
  validates_presence_of :award_frequency_type, :award_program_name, :end_cycle, :intro_text, :start_cycle,:user_id,:email_sender_name,:email_sender_email,:email_sender_subject1,:email_sender_body1,:email_sender_subject2,:email_sender_body2,:email_sender_subject3,:email_sender_body3
  validates :email_sender_email,:uniqueness => { :case_sensitive => false }
  validates_numericality_of :reminder1_days,:reminder2_days,:reminder3_days
end
