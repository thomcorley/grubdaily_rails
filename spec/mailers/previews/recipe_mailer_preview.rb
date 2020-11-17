# Preview all emails at http://localhost:3000/rails/mailers/recipe_mailer
class RecipeMailerPreview < ActionMailer::Preview
  def new_recipe
    RecipeMailer.new_recipe(recipe: Recipe.all.sample, email: "thomcorley@gmail.com")
  end
end
