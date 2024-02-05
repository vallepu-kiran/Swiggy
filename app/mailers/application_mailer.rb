# This is the ApplicationMailer class, the base class for all mailers in your application.
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
