module Api
  class RecipesController < ApplicationController
    def index
      recipes = Recipe.all

      respond_to do |format|
        format.json {
          render json: recipes , include: [:ingredient_entries, :method_steps]
        }
      end
    end

    def sample
      recipe = Recipe.all.sample

      respond_to do |format|
        format.json {
          render json: recipe , include: [:ingredient_entries, :method_steps]
        }
      end
    end
  end
end
