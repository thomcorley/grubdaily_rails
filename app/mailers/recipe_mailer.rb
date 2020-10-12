class RecipeMailer < ApplicationMailer
  default from: "noreply@grubdaily.com"

  CONTACT_EMAIL = "thomcorley@gmail.com"

  def new_recipe(message)
    @message = message
    mail(to: CONTACT_EMAIL, subject: "New recipe")
  end
end
