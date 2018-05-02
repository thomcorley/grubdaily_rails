class RecipeImporter
	include ActiveModel::AttributeMethods
	include ActiveModel::AttributeAssignment

	require "yaml"

	attr_accessor  :content, :title, :total_time, :serves, :makes, :type, :category, :tags, :summary,
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
			type: content_hash[:type],
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
end