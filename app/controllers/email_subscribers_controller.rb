class EmailSubscribersController < ApplicationController
  def create
    email = params[:email]
    subscriber = EmailSubscriber.create!(email: email)
    Rails.logger.info("New email subscriber: id##{subscriber.id}")
    flash[:email_subscribed_notice] = "Subscribed! Check your inbox for confirmation."
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
end
