class Prop < ActiveRecord::Base
  attr_accessible :assign_points, :body, :body2, :body3, :email, :enable, :end_cycle, 
            :end_point, :intro, :name, :reset_point, :start_cycle, :start_point,

            :step_point, :subject, :subject2, :subject3, :user_id,:reminder1_days,:reminder2_days,:reminder3_days

 
  validates_presence_of :step_point,:body, :body2, :body3, :email,:subject, :subject2, :subject3
  validates_numericality_of :start_point,:end_point,:step_point,:reminder1_days,:reminder2_days,:reminder3_days
  validates_presence_of :email,:uniqueness => { :case_sensitive => false }
  validates_presence_of :start_point, :end_point
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

   
  belongs_to :user
  has_many :prop_cycles
 
end
