class IngredientEntriesController < ApplicationController
  before_action :set_instance_variables, only: [:show, :edit, :touch, :update, :destroy]

  def index
    @ingredient_entries = IngredientEntry.where("updated_at < ?", Date.new(2020,5,27)).order(original_string: :asc)
  end

  def show
  end

  def new
    @ingredient_entry = IngredientEntry.new
  end

  def edit
  end

  def touch
    @ingredient_entry.touch
    redirect_to ingredient_entries_path, notice: 'Timestamp updated'
  end

  def create
    @ingredient_entry = IngredientEntry.new(ingredient_entry_params)

    respond_to do |format|ingr
      if @ingredient_entry.save
        format.html { redirect_to @ingredient_entry, notice: 'Ingredient entry was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient_entry }
      else
        format.html { render :new }
        format.json { render json: @ingredient_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # @ingredient_entries = IngredientEntry.where("created_at < ?", Date.new(2020,5,27)).order(original_string: :asc)
    respond_to do |format|
      if @ingredient_entry.update(ingredient_entry_params)
        format.html { redirect_to ingredient_entries_path, notice: 'Ingredient entry was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @ingredient_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ingredient_entry.destroy
    respond_to do |format|
      format.html { redirect_to ingredient_entries_url, notice: 'Ingredient entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance_variables
      @ingredient_entry = IngredientEntry.find(params[:id])
      @recipe = @ingredient_entry.ingredient_set.recipe
      @ingredient = @ingredient_entry.ingredient
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_entry_params
      params.require(:ingredient_entry).permit(:quantity, :unit, :size, :modifier, :original_string)
    end
end
