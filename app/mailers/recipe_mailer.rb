class RecipeMailer < ApplicationMailer
  default from: "grubdaily <grubdaily@mail.grubdaily.com>"

  def new_recipe(recipe:, email_subscriber:)
    @recipe = recipe
    @email_subscriber = email_subscriber
    @host = ActionMailer::Base.default_url_options[:host]
    headers["List-Unsubscribe"] = delete_email_subscriber_url(id: @email_subscriber.id)

    mail(to: @email_subscriber.email, subject: "Something tasty for you: #{@recipe.title}")
    Rails.logger.info("Successfully sent new recipe email for #{@recipe.title}")
  end
end
