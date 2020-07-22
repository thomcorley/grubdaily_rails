class HomeController < ApplicationController
  def index
    recipes_for_display = Recipe.last(7)

    @latest_recipe = recipes_for_display[6]
    @next_two_latest_recipes = recipes_for_display[4..5]
    @recent_recipes = recipes_for_display[0..3]
  end

  def about

  end

  def recipe_index

  end

  def photos

  end
end
