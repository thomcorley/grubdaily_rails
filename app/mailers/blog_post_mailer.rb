class BlogPostMailer < ApplicationMailer
  TEST_EMAILS = RecipeMailer::TEST_EMAILS

  default from: "grubdaily <grubdaily@mail.grubdaily.com>"

  def new_blog_post(blog_post:, email_subscriber:)
    @blog_post = blog_post
    @email_subscriber = email_subscriber
    @host = ActionMailer::Base.default_url_options[:host]
    headers["List-Unsubscribe"] = delete_email_subscriber_url(id: @email_subscriber.id)

    mail(to: @email_subscriber.email, subject: "Food for thought: #{@blog_post.title}")
    Rails.logger.info("Successfully sent new blog post email for #{@blog_post.title}")
  end
end
