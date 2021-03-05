class BulkRecipeEmailer
  def self.deliver_email_update(recipe)
    EmailSubscriber.confirmed.each do |email_subscriber|
      next if RecipeMailer::TEST_EMAILS.include?(email_subscriber.email)
      RecipeMailer.new_recipe(recipe: recipe, email_subscriber: email_subscriber).deliver
    end
  end
end
