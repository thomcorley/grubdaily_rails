class EmailSubscribersController < ApplicationController
  def delete
    @email_subscriber = EmailSubscriber.find(params[:id])
    @email_subscriber.destroy
    Rails.logger.info("EmailSubscriber##{@email_subscriber.id} was unsubscribed")
  end
end
