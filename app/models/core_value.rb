class CoreValue < ActiveRecord::Base
   attr_accessible :title, :description,:setting_id
   belongs_to :setting
end
