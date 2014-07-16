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

   Plan.create(:name => "Applaud", :price => "0.50",
    :forusers = " <div class="spec" style="font-size: 15px; color: rgb(102, 102, 102); margin-bottom: 13px;"><ul><li><span style="line-height: 1.42857;">Send props - publicly praise peers</span><br></li><li><span style="line-height: 1.42857;">View props posted by others</span><br></li><li><span style="line-height: 1.42857;">Assign points to co-workers while sending props</span><br></li><li><span style="line-height: 1.42857;">Let employees accumulate points to redeem for prizes</span><br></li><li><span style="line-height: 1.42857;">View a leaderboard based on props</span><br></li></ul></div>",
    :foradmins = "<div class="spec" style="font-size: 15px; color: rgb(102, 102, 102); margin-bottom: 13px;"><ul><li><span style="line-height: 1.42857;">View results and select a winner</span><br></li><li><span style="line-height: 1.42857;">Select multiple winners</span><br></li><li><span style="line-height: 1.42857;">Set weekly, monthly or quarterly cycle</span><br></li><li><span style="line-height: 1.42857;">Reset points at the end of cycle</span><br></li><li><span style="line-height: 1.42857;">Set how many points an employee can dole out</span><br></li><li><span style="line-height: 1.42857;">Exhibit a Wall-of-Winners</span><br></li><li><span style="line-height: 1.42857;">Send automated reminders to employees</span><br></li><li><span style="line-height: 1.42857;">Set text of automated reminder emails</span><br></li><li><span style="line-height: 1.42857;">Manage users</span><br></li><li><span style="line-height: 1.42857;">Analyze winners, usage patterns and other data points</span><br></li><li><span style="line-height: 1.42857;">Support via email</span><br></li></ul></div>",
    :pricing = "<div style="text-align: center;"><span style="color: rgb(60, 162, 229); font-size: 15px; line-height: 21px;">$0.50/user/month</span></div><div style="text-align: center;">Pay for active users only</div>")
	 Plan.create(:name => "Award", :price => "0.50",
    :forusers = "<div class="spec" style="font-size: 15px; color: rgb(102, 102, 102); margin-bottom: 13px;"><ul><li><span style="line-height: 1.42857;">Submit vote - privately vote for peers</span><br></li><li><span style="line-height: 1.42857;">Select company core values exhibited by peer receving the vote</span><br></li><li><span style="line-height: 1.42857;">Provide a comment while voting</span><br></li><li><span style="line-height: 1.42857;">View who you voted for recently</span><br></li><li><span style="line-height: 1.42857;">View who won recently</span><br></li></ul></div>",
    :foradmins = "<div class="spec" style="font-size: 15px; color: rgb(102, 102, 102); margin-bottom: 13px;"><ul><li><span style="line-height: 1.42857;">View results and select a winner</span><br></li><li><span style="line-height: 1.42857;">Select multiple winners</span><br></li><li><span style="line-height: 1.42857;">Set weekly, monthly or quarterly cycle</span><br></li><li><span style="line-height: 1.42857;">Nominate who employees can vote for</span><br></li><li><span style="line-height: 1.42857;">Disallow the last winner from receiving votes</span><br></li><li><span style="line-height: 1.42857;">Exhibit a Wall-of-Winners</span><br></li><li><span style="line-height: 1.42857;">Send automated reminders to employees</span><br></li><li><span style="line-height: 1.42857;">Set text of automated reminder emails</span><br></li><li><span style="line-height: 1.42857;">Manage users</span><br></li><li><span style="line-height: 1.42857;">Analyze winners, usage patterns and other data points</span><br></li><li><span style="line-height: 1.42857;">Support via email</span><br></li></ul></div>",
    :pricing = "<div style="text-align: center;"><span style="color: rgb(60, 162, 229); font-size: 15px; line-height: 21px;">$0.50/user/month</span></div><div style="text-align: center;">Pay for active users only</div>")
   Plan.create(:name => "Alloy", :price => "1.00",
    :forusers = "<ul><li><span style="color: rgb(102, 102, 102); font-size: 15px; line-height: 21px;">Props and votes</span></li></ul>",
    :foradmins = "<div class="spec" style="font-size: 15px; color: rgb(102, 102, 102); margin-bottom: 13px;"><ul><li><span style="line-height: 1.42857;">Everything in the Applaud and Award plans</span><br></li></ul></div><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><div style="font-size: 2px">&nbsp;</div>",
    :pricing = "<div style="text-align: center;"><span style="color: rgb(60, 162, 229); font-size: 15px; line-height: 21px;">$1.00/user/month</span></div><div style="text-align: center;">Pay for active users only</div>")
     
   TrialDay.create(:days =>"99")



     padmin = User.create(:username => 'productadmin', :email=> 'productadmin@padmin.com', :password => 'mer_admin123!', :firstname => "padmin", 
	   :lastname => "padmin")
     padmin.roles = [Role.first]
     padmin.save
    