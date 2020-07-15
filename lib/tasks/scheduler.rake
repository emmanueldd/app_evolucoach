desc "Envoie au coach les cours modifiés récement"
task :send_courses_changed_recently_to_user => :environment do
  puts "Envoie au coach les cours modifiés récement"
  Course.send_courses_changed_recently_to_user
  puts "done."
end
