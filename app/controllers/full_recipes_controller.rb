class FullRecipesController < ApplicationController
  before_action :set_full_recipe, only: [:show, :edit, :update, :destroy]

  # GET /full_recipes
  # GET /full_recipes.json
  def index
    @full_recipes = FullRecipe.all
  end

  # GET /full_recipes/1
  # GET /full_recipes/1.json
  def show
  end

  # GET /full_recipes/new
  def new
    @full_recipe = FullRecipe.new
  end

  # GET /full_recipes/1/edit
  def edit
  end

  # POST /full_recipes
  # POST /full_recipes.json
  def create
    @full_recipe = FullRecipe.new(full_recipe_params)

    respond_to do |format|
      if @full_recipe.save
        format.html { redirect_to @full_recipe, notice: 'Full recipe was successfully created.' }
        format.json { render :show, status: :created, location: @full_recipe }
      else
        format.html { render :new }
        format.json { render json: @full_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /full_recipes/1
  # PATCH/PUT /full_recipes/1.json
  def update
    respond_to do |format|
      if @full_recipe.update(full_recipe_params)
        format.html { redirect_to @full_recipe, notice: 'Full recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @full_recipe }
      else
        format.html { render :edit }
        format.json { render json: @full_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /full_recipes/1
  # DELETE /full_recipes/1.json
  def destroy
    @full_recipe.destroy
    respond_to do |format|
      format.html { redirect_to full_recipes_url, notice: 'Full recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_full_recipe
      @full_recipe = FullRecipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def full_recipe_params
      params.fetch(:full_recipe, {})
    end
end
