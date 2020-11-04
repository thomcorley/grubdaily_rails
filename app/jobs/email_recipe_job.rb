class EmailRecipeJob < ApplicationJob
  queue_as :default

  def perform(message)
    RecipeMailer.new_recipe(message).deliver
  end
end
