class RecipesController < ApplicationController
  include ApplicationHelper

  before_action :set_entry, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  before_action :authenticate, only: [:index, :edit, :update, :destroy, :create, :publish]

  def index
    @entries = Entry.all
  end

  def show
    unless @entry
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end

    @ingredient_sets = @entry.ingredient_sets

    @introduction_paragraphs = @entry.introduction.split("\n").map do |paragraph|
      MarkdownConverter.convert(paragraph)
    end

    @method_steps_with_description = @entry.method_steps.order(:position).map do |method_step|
      OpenStruct.new(
        method_step: method_step,
        description: MarkdownConverter.convert(method_step.description)
      )
    end

    @ingredient_entries = @entry.ingredient_entries

    @tags = @entry.tags.split(",")

    @prev_entry = Entry.find_by_id(@entry.id - 1)
    @next_entry = Entry.find_by_id(@entry.id + 1)
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def create
    @recipe = recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'recipe was successfully created.' }
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
        format.html { redirect_to @recipe, notice: 'recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish
    # Only send a new recipe email if the recipe hasn't been published before
    unless @recipe.published_at
      BulkrecipeEmailer.deliver_email_update(@recipe)
    end

    @recipe.publish!
    redirect_to recipe_path(@recipe), flash: { notice: "recipe successfully published!" }
  end

  def unpublish
    @recipe.unpublish!
    redirect_to recipe_path(@recipe), flash: { notice: "recipe unpublished" }
  end

  def destroy
    @recipe.destroy
    redirect_to recipe_index_path, flash: { notice: "recipe was successfully deleted" }
  end

  def feed
    @recipes = recipe.published.order(published_at: :desc)
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
      @recipe = Entry.all.find { |recipe| entry.permalink == "/#{params["entry_path"]}" }
    elsif params[:id]
      @entry = entry.find_by_id(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.require(:recipe).permit(:title, :summary, :total_time, :introduction, :serves, :makes, :makes_unit, :recipe_type, :tags)
  end
end
