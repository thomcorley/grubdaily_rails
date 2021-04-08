class BlogPostMailer < ApplicationMailer
  TEST_EMAILS = RecipeMailer::TEST_EMAILS

  default from: "grubdaily <grubdaily@mail.grubdaily.com>"

  def new_blog_post(blog_post:, email_subscriber:)
    @blog_post = blog_post
    @email_subscriber = email_subscriber
    raw_introduction = @blog_post.content_paragraphs.first.delete_suffix(".")
    read_more_link = "... [Read More](https://www.grubdaily.com#{@blog_post.permalink})"
    introduction_with_read_more_link = raw_introduction + read_more_link
    @introduction = MarkdownConverter.convert(introduction_with_read_more_link)

    @host = ActionMailer::Base.default_url_options[:host]
    headers["List-Unsubscribe"] = delete_email_subscriber_url(id: @email_subscriber.id)
    attachments.inline["blog_post.jpg"] = File.read("#{Rails.root}/app/assets/images/#{@blog_post.image}.jpg")

    mail(to: @email_subscriber.email, subject: "Food for thought: #{@blog_post.title}")
    Rails.logger.info("Successfully sent new blog post email for #{@blog_post.title}")
  end
end
