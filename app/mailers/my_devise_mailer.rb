class MyDeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'layouts/mailer' # to make sure that your mailer uses the devise views
  layout 'layouts/mailer'
  default from: '"Evolucoach" <contact@evolucoach.com>'
end
