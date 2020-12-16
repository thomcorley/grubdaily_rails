class EmailSubscriptionConfirmationMailer < ApplicationMailer
  default from: "grubdaily <grubdaily@mail.grubdaily.com>"

  def send_confirmation(email_subscriber:)
    @email_subscriber = email_subscriber
    @host = ActionMailer::Base.default_url_options[:host]
    headers["List-Unsubscribe"] = delete_email_subscriber_url(id: @email_subscriber.id)

    mail(to: @email_subscriber.email, subject: "Please confirm your Grubdaily subscription")
    Rails.logger.info("Successfully sent subscription confirmation for EmailSubscriber##{@email_subscriber.id}")
  end
end
