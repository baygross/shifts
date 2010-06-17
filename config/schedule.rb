# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :cron_log, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
every :sunday, :at => "9am" do
  rake "auto_remind"
end

every :day, at => "1am" do 
 rake "email_stats"
end

every :day, at => "1am" do #time to change soon, just example 
  rake "stale_shift_email"
end

every 3.minutes do
  command "/usr/bin/ar_sendmail -o --chdir #{rails_root} --environment production"
end