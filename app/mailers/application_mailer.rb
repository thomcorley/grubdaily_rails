class ApplicationMailer < ActionMailer::Base
  ADMIN_EMAIL_ADDRESS = "tom@grubdaily.com"

  default from: "from@example.com"
  layout "mailer"
end
