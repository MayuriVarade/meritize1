# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 	 Role.create(:name => "productmanager")
	 Role.create(:name => "admin")
      Role.create(:name => "user")

      Plan.create(:name => "Applaud", :price => "0.50")
	 Plan.create(:name => "Award", :price => "0.50")
      Plan.create(:name => "Alloy", :price => "1.00")


     padmin = User.create(:username => 'productadmin', :email=> 'productadmin@padmin.com', :password => 'admin123!', :firstname => "padmin", 
	:lastname => "padmin")
     padmin.roles = [Role.first]
     padmin.save
    