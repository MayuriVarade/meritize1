desc "Tasks called by the Heroku scheduler add-on"
task :update_cycle => :environment do
  puts 'Update Cycle was called'
end

task :send_reminders => :environment do
  puts 'Send Reminders was called'
end