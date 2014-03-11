class Setting < ActiveRecord::Base

  attr_accessible :company_name, :description, :website_address,:user_id,:photo,:core_values_attributes
  belongs_to :user
  has_many :core_values,:dependent => :destroy
  accepts_nested_attributes_for :core_values, :allow_destroy => true 
  has_attached_file :photo,:styles =>{:small => "150x150>"}
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png"]

end
