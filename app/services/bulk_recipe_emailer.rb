class BulkRecipeEmailer
  def self.deliver_email_update(recipe)
    EmailSubscriber.all.each do |email_subscriber|
      RecipeMailer.new_recipe(recipe: recipe, email_subscriber: email_subscriber).deliver
    end
  end
end
