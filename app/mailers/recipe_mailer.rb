class RecipeMailer < ApplicationMailer
  default from: "noreply@grubdaily.com"

  def new_recipe(recipe:, email:)
    @recipe = recipe
    mail(to: email, subject: "Something tasty for you: #{@recipe.title}")
  end
end
