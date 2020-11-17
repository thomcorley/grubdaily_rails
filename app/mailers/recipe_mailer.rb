class RecipeMailer < ApplicationMailer
  default from: "grubdaily <noreply@grubdaily.com>"

  def new_recipe(recipe:, email:)
    @recipe = recipe
    @host = ActionMailer::Base.default_url_options[:host]

    mail(to: email, subject: "Something tasty for you: #{@recipe.title}")
    Rails.logger.info("Successfully sent new recipe email for #{@recipe.title}")
  end
end
