class RecipeImportsController < ApplicationController

  def new
    @recipe_import = RecipeImport.new
    @recipe_import.content = params[:content]
  end

  def create
    content = params[:content]

    importer = RecipeImporter.new(content)
    recipe_id = importer.save_recipe

    importer.save_ingredients(recipe_id)
    importer.save_method_steps(recipe_id)
    importer.save_tags(recipe_id)

    redirect_to recipe_path(recipe_id)
  end
end
