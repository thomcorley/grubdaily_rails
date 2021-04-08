class RecipesController < ApplicationController
  include ApplicationHelper

  before_action :set_recipe, only: [
    :show, :edit, :update, :destroy, :publish, :unpublish, :test_email, :bulk_send_emails
  ]

  before_action :authenticate, only: [
    :index, :edit, :update, :destroy, :create, :publish, :unpublish, :test_email, :bulk_send_emails
  ]

  def index
    @recipes = Recipe.all
  end

  def show
    unless @recipe
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end

    @ingredient_sets = @recipe.ingredient_sets

    @introduction_paragraphs = @recipe.introduction.split("\n").map do |paragraph|
      MarkdownConverter.convert(paragraph)
    end

    @method_steps_with_description = @recipe.method_steps.order(:position).map do |method_step|
      OpenStruct.new(
        method_step: method_step,
        description: MarkdownConverter.convert(method_step.description)
      )
    end

    @ingredient_entries = @recipe.ingredient_entries

    @tags = @recipe.tags.split(",")

    @prev_recipe = Recipe.find_by_id(@recipe.id - 1)
    @next_recipe = Recipe.find_by_id(@recipe.id + 1)
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish
    @recipe.publish!
    redirect_to recipe_path(@recipe), flash: { notice: "Recipe successfully published!" }
  end

  def unpublish
    @recipe.unpublish!
    redirect_to recipe_path(@recipe), flash: { notice: "Recipe unpublished" }
  end

  def test_email
    subscribers = EmailSubscriber.where(email: RecipeMailer::TEST_EMAILS)

    subscribers.each do |subscriber|
      RecipeMailer.new_recipe(recipe: @recipe, email_subscriber: subscriber).deliver
    end

    message = "Test emails were sent to: #{subscribers.map(&:email).join(", ")}"

    redirect_to recipe_path(@recipe), flash: { notice: message }
  end

  def bulk_send_emails
    # Only send a new recipe email if the recipe hasn't been published before
    unless @recipe.published_at
      BulkRecipeEmailer.deliver_email_update(@recipe)
    end
    redirect_to recipe_path(@recipe), flash: { notice: "Delivered bulk email update!" }
  end

  def destroy
    @recipe.destroy
    redirect_to recipe_index_path, flash: { notice: "Recipe was successfully deleted" }
  end

  def feed
    @recipes = Recipe.published.order(published_at: :desc)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private

  def authenticate
    not_found unless admin_session?
  end

  def set_recipe
    # Confusingly, `recipe_title` is usually the permalink of the recipe, but sometimes the ID
    if params["recipe_path"]
      @recipe = Recipe.all.find { |recipe| recipe.permalink == "/#{params["recipe_path"]}" }
    elsif params[:id]
      @recipe = Recipe.find_by_id(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recipe_params
    params.require(:recipe).permit(:title, :summary, :total_time, :introduction, :serves, :makes, :makes_unit, :recipe_type, :tags)
  end
end
