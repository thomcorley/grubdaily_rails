class RecipeImporter
	include ActiveModel::AttributeMethods
	include ActiveModel::AttributeAssignment

	require "yaml"

	attr_accessor  :content, :title, :total_time, :serves, :makes, :recipe_type, :category, :tags, :summary,
						 :introduction, :ingredient_sets, :method_steps


	def initialize(content)
		@content = content
	end

	def populate_fields
		self.assign_attributes(attributes)
	end

	def content_hash
		YAML.load(@content).deep_symbolize_keys
	end

	def attributes
		{
			title: content_hash[:title],
			total_time: content_hash[:total_time],
			serves: content_hash[:serves],
			makes: content_hash[:makes],
			recipe_type: content_hash[:type],
			category: content_hash[:category],
			tags: content_hash[:tags],
			summary: content_hash[:summary],
			introduction: content_hash[:introduction].join("\n"),
			ingredient_sets: ingredient_sets,
			method_steps: content_hash[:method_steps],
		}
	end

	def ingredient_sets
		[content_hash[:first_ingredient_set], content_hash[:second_ingredient_set], content_hash[:third_ingredient_set]]
	end

	# This should be an array of method steps
	def method_steps
		content_hash[:method_steps]
	end

	def save_recipe
		params = attributes.slice(:title, :total_time, :serves, :makes, :category, :recipe_type, :summary, :introduction)
		recipe = Recipe.create!(params)
		recipe.id
	end

	def save_ingredients(recipe_id)
		processor = IngredientsProcessor.new(ingredient_sets)
		
		processor.params_for_ingredient_sets(recipe_id).each_with_index do |ingredient_set_params, i|
			ingredient_set = IngredientSet.create!(ingredient_set_params)

			processor.params_for_ingredient_entries(ingredient_set.id, i).each do |ingredient_entry_params|
				ingredient_entry = IngredientEntry.create!(ingredient_entry_params)
				ingredient = Ingredient.create(processor.params_for_ingredient(ingredient_entry.id))
			end
		end		
	end

	def save_method_steps(recipe_id)
		method_steps.each_with_index do |m, i|
			MethodStep.create!(position: i + 1, description: m, recipe_id: recipe_id)
		end
	end

	def save_tags(recipe_id)
		tags_array = content_hash[:tags].split(", ")

		tags_array.each do |t|
			Tag.create!(name: t, taggable_type: "Recipe", taggable_id: recipe_id)
		end
	end
end