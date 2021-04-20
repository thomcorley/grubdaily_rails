class DropBlogPostsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :blog_posts
  end
end
