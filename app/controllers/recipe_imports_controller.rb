class RecipeImportsController < ApplicationController

  def new
    @recipe_import = RecipeImport.new
    @recipe_import.content = params[:content]
  end

  def create
    content = params[:content]

    importer = RecipeImporter.new(content)
    importer.save_recipe
  end

end
