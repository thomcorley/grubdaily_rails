class JekyllPostsController < ApplicationController

	def generate
		@recipe = Recipe.find(params[:recipe_id])
		@category = @recipe.tags.first.name
		@tags = @recipe.tags.map(&:name)
	end
end