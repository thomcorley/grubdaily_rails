class BulkRecipeEmailer
  def self.deliver_email_update(recipe)
    emails = EmailSubscriber.all.pluck(:email)

    emails.each do |email|
      RecipeMailer.new_recipe(recipe: recipe, email: email).deliver
    end
  end
end
