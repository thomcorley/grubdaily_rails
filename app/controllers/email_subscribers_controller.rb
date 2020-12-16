class EmailSubscribersController < ApplicationController
  def create
    email = params[:email]
    subscriber = EmailSubscriber.create!(email: email, confirmed: false)
    Rails.logger.info("New email subscriber: id##{subscriber.id}")
    redirect_to send_confirmation_email_subscriber_path(subscriber.id)
  rescue ActiveRecord::RecordInvalid => e
    flash[:validation_error] = e.message
    Rails.logger.error("Could not save email subscription: #{e.message}")
    redirect_to "#{root_url}#subscribed"
  end

  def delete
    @email_subscriber = EmailSubscriber.find(params[:id])
    @email_subscriber.destroy
    Rails.logger.info("EmailSubscriber##{@email_subscriber.id} was unsubscribed")
  rescue ActiveRecord::RecordNotFound => ex
    Rails.logger.info("#{ex}: Redirecting to homepage")
    redirect_to root_url
  end

  def send_confirmation
    @email_subscriber = EmailSubscriber.find(params[:id])
    EmailSubscriptionConfirmationMailer.send_confirmation(email_subscriber: @email_subscriber).deliver_now
  end

  def confirm
    @email_subscriber = EmailSubscriber.find(params[:id])
    @email_subscriber.confirm!
    Rails.logger.info("Confirmed subscription for EmailSubscriber##{@email_subscriber.id}")
  end
end
