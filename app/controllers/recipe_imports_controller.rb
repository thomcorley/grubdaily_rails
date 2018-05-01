class RecipeImportsController < ApplicationController

  def new
    @recipe_import = RecipeImport.new
    @recipe_import.content = params[:content]
  end

  def create
    # TODO: add logic for parsing the YAML of recipe content and saving it to the database
  end
  
end
