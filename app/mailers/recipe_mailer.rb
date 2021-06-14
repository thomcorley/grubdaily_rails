class RecipeMailer < ApplicationMailer
  TEST_EMAILS = ["thomcorley@gmail.com"]

  default from: "grubdaily <grubdaily@mail.grubdaily.com>"

  def new_recipe(recipe:, email_subscriber:)
    @recipe = recipe
    @email_subscriber = email_subscriber

    raw_introduction = @recipe.introduction_paragraphs.first.delete_suffix(".")
    read_more_link = "... [Read More](https://www.grubdaily.com#{@recipe.permalink})"
    introduction_with_read_more_link = raw_introduction + read_more_link
    @introduction = MarkdownConverter.convert(introduction_with_read_more_link)

    @host = ActionMailer::Base.default_url_options[:host]
    headers["List-Unsubscribe"] = delete_email_subscriber_url(id: @email_subscriber.id)
    attachments.inline["recipe.jpg"] = File.read("#{Rails.root}/app/assets/images/#{@recipe.image}.jpg")

    mail(to: @email_subscriber.email, subject: "Something tasty for you: #{@recipe.title}")
    Rails.logger.info("Successfully sent new recipe email for #{@recipe.title}")
  end
end
