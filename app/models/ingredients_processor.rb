class IngredientsProcessor

	# Takes an array of unformatted ingredient sets
	def initialize(ingredient_sets)
		@ingredient_sets = ingredient_sets
	end

	# This method returns an array of hashes, each hash being the
	# params to create an IngredientSet, :title, :position, :recipe_id
	def params_for_ingredient_sets(recipe_id)
		array_of_params = []

		@ingredient_sets.each_with_index do |set, i|
			if set
				set.first[0] == :INSERT_TITLE ? title = nil : title = set.first[0]
				array_of_params << {title: title, position: i + 1, recipe_id: recipe_id}
			end
		end

		array_of_params
	end

	# This method returns an array of hashes, each hash being the
	# params to create an IngredientEntry 
	# :quantity, :unit, :size, :modifier, :ingredient_set_id
	def params_for_ingredient_entries(ingredient_set_id, index_of_ingredient_set)
		array_of_params = []
		set_id = ingredient_set_id

		ingredient_entry_strings(index_of_ingredient_set).each do |string|
			array_of_params << IngredientEntryProcessor.new(string, set_id).parse
		end
		array_of_params
	end

	def params_for_ingredient(ingredient_entry_id)
		ingredient_entry = IngredientEntry.find(ingredient_entry_id)
		ingredient_set_id = ingredient_entry.ingredient_set_id
		ingredient_name = IngredientEntryProcessor.new(ingredient_entry.original_string, ingredient_set_id).get_ingredient
		{name: ingredient_name, ingredient_entry_id: ingredient_entry_id}
	end

	# PRIVATE METHODS?

	# Returns an array of unprocessed ingredient entries 
	# belonging to an ingredient set
	def ingredient_entry_strings(index_of_ingredient_set)
		@ingredient_sets[index_of_ingredient_set].first[1]
	end
end