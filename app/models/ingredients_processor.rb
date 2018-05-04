class IngredientsProcessor

	# Expects an array of ingredient sets
	def initialize(ingredient_sets)
		@ingredient_sets = ingredient_sets
	end

	# This method returns an array of hashes, each hash being the
	# params to create an IngredientSet, :title, :position, :recipe_id
	def params_for_ingredient_sets(recipe_id)
		position = 0
		array_of_params = []

		@ingredient_sets.each do |set|
			position += 1

			if set
				set.first[0] == "INSERT_TITLE" ? title = nil : title = set.first[0]
				array_of_params << {title: title, position: position, recipe_id: recipe_id}
			end
		end

		array_of_params
	end

	# This method returns an array of hashes, each hash being the
	# params to create an IngredientEntry 
	# :quantity, :unit, :size, :modifier, :ingredient_set_id
	def params_for_ingredient_entries(ingredient_set_id)
		array_of_params = []
		set_id = ingredient_set_id

		ingredient_entry_strings.each do |string|
			array_of_params << IngredientEntryProcessor.new(string, set_id).parse
		end
		array_of_params
	end

	def params_for_ingredient(ingredient_entry_id)

	end

	def params_for_method_steps(recipe_id)

	end

	# PRIVATE METHODS?

	# TODO: create a new class called IngredientEntryProcessor
	# which will handle just the parsing of an individual entry string.
	# This will also make the spec much nicer to construct, and to read later.

	# Returns an array of unprocessed ingredient entries 
	# belonging to an ingredient set
	def ingredient_entry_strings(ingredient_set)
		ingredient_set.first[1]
	end
end