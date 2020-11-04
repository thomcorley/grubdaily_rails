class RecipeMailer < ApplicationMailer
  default from: "noreply@grubdaily.com"

  CONTACT_EMAIL = "thomcorley@gmail.com"

  def new_recipe(subject, message)
    # @message = message
    # mail(to: CONTACT_EMAIL, subject: "New recipe")
    RestClient.post(
      #TODO: add api key here
      from: "Tommy <tom@grubdaily.com>",
      to: "thomcorley@gmail.com",
      subject: subject,
      text: message
    )
  end
end
