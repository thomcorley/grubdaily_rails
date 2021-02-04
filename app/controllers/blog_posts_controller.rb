class BlogPostsController < ApplicationController
  include ApplicationHelper

  before_action :set_blog_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  before_action :authenticate, only: [:new, :index, :edit, :update, :destroy, :create, :publish, :unpublish]

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Blog Post was successfully created.' }
        format.json { render :show, status: :created, location: @blog_post }
      else
        format.html { render :new }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @tags = @blog_post.tags.split(",")
    @prev_post = BlogPost.find_by_id(@blog_post.id - 1)
    @next_post = BlogPost.find_by_id(@blog_post.id + 1)
  end

  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to @blog_post, notice: 'Blog Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :edit }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end


  def publish
    # Only send if it hasn't been published before
    unless @blog_post.published_at
      BulkBlogPostEmailer.deliver_email_update(@blog_post)
    end

    @blog_post.publish!
    redirect_to blog_post_path(@blog_post), flash: { notice: "Blog post successfully published!" }
  end

  def unpublish
    @blog_post.unpublish!
    redirect_to blog_post_path(@blog_post), flash: { notice: "Blog post unpublished" }
  end

  private

  def authenticate
    not_found unless admin_session?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_post_params
    params.require(:blog_post).permit(:title, :summary, :content, :images, :tags, :published, :published_at)
  end

  def set_blog_post
    # Confusingly, `recipe_title` is usually the permalink of the recipe, but sometimes the ID
    if params["blog_post_path"]
      @blog_post = BlogPost.all.find { |blog_post| blog_post.permalink == "/posts/#{params["blog_post_path"]}" }
    elsif params[:id]
      @blog_post = BlogPost.find(params[:id])
    end
  end
end
