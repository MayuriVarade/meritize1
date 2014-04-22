class TrialDay < ActiveRecord::Base
  attr_accessible :days
  validates :days, :numericality => { :greater_than_or_equal_to => 0 }

  has_many :users
end
