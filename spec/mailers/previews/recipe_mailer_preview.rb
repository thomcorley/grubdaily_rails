# Preview all emails at http://localhost:3000/rails/mailers/recipe_mailer
class RecipeMailerPreview < ActionMailer::Preview
  def new_recipe
    email_subscriber = EmailSubscriber.create!(email: "mail@example.com")
    RecipeMailer.new_recipe(recipe: Recipe.all.sample, email_subscriber: email_subscriber)
  end
end
