class ContactFormMailer < ApplicationMailer
  default from: "grubdaily <grubdaily@mail.grubdaily.com>"
  default reply_to: -> { @contact_form_message.email }

  def new_message(contact_form_message)
    @contact_form_message = contact_form_message
    @host = ActionMailer::Base.default_url_options[:host]

    mail(to: ADMIN_EMAIL_ADDRESS, subject: "New contact form message")
    Rails.logger.info("Successfully sent a new contact form message")
  end
end
