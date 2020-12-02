class EmailSubscribersController < ApplicationController
  def delete
    @email_subscriber = EmailSubscriber.find(params[:id])
    @email_subscriber.destroy
    Rails.logger.info("EmailSubscriber##{@email_subscriber.id} was unsubscribed")
  rescue ActiveRecord::RecordNotFound => ex
    Rails.logger.info("#{ex}: Redirecting to homepage")
    redirect_to root_url
  end
end
