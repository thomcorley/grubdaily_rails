class IngredientEntriesController < ApplicationController
  before_action :set_ingredient_entry, only: [:show, :edit, :update, :destroy]

  # GET /ingredient_entries
  # GET /ingredient_entries.json
  def index
    @ingredient_entries = IngredientEntry.all
  end

  # GET /ingredient_entries/1
  # GET /ingredient_entries/1.json
  def show
  end

  # GET /ingredient_entries/new
  def new
    @ingredient_entry = IngredientEntry.new
  end

  # GET /ingredient_entries/1/edit
  def edit
    @ingredient_entry = IngredientEntry.find(params[:id])
    @recipe = @ingredient_entry.ingredient_set.recipe
    @ingredient = @ingredient_entry.ingredient
  end

  # POST /ingredient_entries
  # POST /ingredient_entries.json
  def create
    @ingredient_entry = IngredientEntry.new(ingredient_entry_params)

    respond_to do |format|
      if @ingredient_entry.save
        format.html { redirect_to @ingredient_entry, notice: 'Ingredient entry was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient_entry }
      else
        format.html { render :new }
        format.json { render json: @ingredient_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredient_entries/1
  # PATCH/PUT /ingredient_entries/1.json
  def update
    respond_to do |format|
      if @ingredient_entry.update(ingredient_entry_params)
        format.html { redirect_to @ingredient_entry, notice: 'Ingredient entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient_entry }
      else
        format.html { render :edit }
        format.json { render json: @ingredient_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredient_entries/1
  # DELETE /ingredient_entries/1.json
  def destroy
    @ingredient_entry.destroy
    respond_to do |format|
      format.html { redirect_to ingredient_entries_url, notice: 'Ingredient entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient_entry
      @ingredient_entry = IngredientEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_entry_params
      params.fetch(:ingredient_entry, {})
    end
end
