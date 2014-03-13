class Prop < ActiveRecord::Base
  attr_accessible :assign_points, :body, :body2, :body3, :email, :enable, :end_cycle, 
  				  :end_point, :intro, :name, :reset_point, :start_cycle, :start_point,
  				  :step_point, :subject, :subject2, :subject3, :user_id
  
  belongs_to :user
  has_many :prop_cycles
  validates_presence_of :start_point,:end_point,:step_point,:body, :body2, :body3, :email,:subject, :subject2, :subject3
  validates_numericality_of :start_point,:end_point,:step_point
end
