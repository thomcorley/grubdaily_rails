# frozen_string_literal: true
class RecipeSeeder
  def self.seed
    count = 0
    Dir.glob("lib/yaml_recipes/*.yaml") do |yaml_filename|
      filepath = Rails.root.join(yaml_filename)
      yaml_file = File.read(filepath)

      ActiveRecord::Base.transaction do
        importer = RecipeImporter.new(yaml_file)
        recipe_id = importer.save_recipe
        importer.save_ingredients(recipe_id)
        importer.save_method_steps(recipe_id)

        count += 1
        puts "Recipe created: #{yaml_filename}"
      rescue StandardError => e
        puts "Error parsing YAML file #{yaml_filename}. Message: #{e}"
      end
    end

    puts "Imported #{count} recipes"
  end
end

RecipeSeeder.seed if Rails.env == "development"
