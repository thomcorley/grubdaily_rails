class RecipeImporter
	include ActiveModel::AttributeMethods
	include ActiveModel::AttributeAssignment

	require "yaml"

	attr_accessor  :content, :title, :total_time, :serves, :makes, :recipe_type, :category, :tags, :summary,
						 :introduction, :ingredient_sets, :method_steps


	def initialize(content)
		@content = content
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
			introduction: content_hash[:introduction],
			ingredient_sets: ingredient_sets,
			method_steps: content_hash[:method_steps],
		}
	end

	def populate_fields
		self.assign_attributes(attributes)
	end

	def ingredient_sets
		[content_hash[:first_ingredient_set], content_hash[:second_ingredient_set], content_hash[:third_ingredient_set]]
	end

	def save_recipe
		params = attributes.slice(:title, :total_time, :serves, :makes, :category, :recipe_type, :summary, :introduction)
		# binding.pry
		recipe = Recipe.create!(params)
		recipe.id
	end

	def save_ingredients(recipe_id)
		processor = IngredientProcessor.new(ingredient_sets)
		
		# Need to add recipe_id to the params below
		processor.params_for_ingredient_sets.each do |ingredient_set_params|
			ingredient_set = IngredientSet.create(params)

			# Need to add ingredient_set_id to the params below
			processor.params_for_ingredient_entries(ingredient_set.id).each do |ingredient_entry_params|
				ingredient_entry = IngredientEntry.create(ingredient_entry_params)
				ingredient = Ingredient.create(processor.params_for_ingredient(ingredient_entry.id))
			end
		end		
	end

	def save_method_steps(recipe_id)
		processor = MethodProcessor.new(recipe_id)
		# Need to add recipe_id to the params below
		processor.params_for_method_steps.each do |params|
			MethodStep.create(params)
		end
	end

	def save_tags(recipe_id)

	end
end