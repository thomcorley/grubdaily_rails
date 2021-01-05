class BulkBlogPostEmailer
  def self.deliver_email_update(blog_post)
    EmailSubscriber.confirmed.each do |email_subscriber|
      BlogPostMailer.new_blog_post(blog_post: blog_post, email_subscriber: email_subscriber).deliver
    end
  end
end
