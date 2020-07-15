web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -q default -q mailers
log: tail -f log/development.log
