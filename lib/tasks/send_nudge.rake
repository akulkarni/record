task :nudge_record_users => :environment do
  require 'open-uri'
  open("http://animal-io.herokuapp.com/record/send_nudge")
end