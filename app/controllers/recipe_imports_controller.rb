class RecipeImportsController < ApplicationController

  def new
    @recipe_import = RecipeImport.new
    @recipe_import.content = params[:content]
  end

  def create
    content = params[:content]

    parser = RecipeImportParser.new(content)
    parser.save_recipe
  end

end
