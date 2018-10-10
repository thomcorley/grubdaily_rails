require 'rails_helper'

RSpec.describe LegacyCsv::Importer, type: :model do

  context "#import" do
  	setup do
  		@importer = LegacyCsv::Importer.new
  	end

  	it "imports 51 recipes" do
  		recipe_count = Recipe.count
  		@importer.import
			new_recipe_count = Recipe.count - recipe_count

  		expect(new_recipe_count).to eq 51
  	end

  	it "imports 51 ingredient_sets" do
  		ingredient_set_count = IngredientSet.count
  		@importer.import
			new_ingredient_set_count = IngredientSet.count - ingredient_set_count

  		expect(new_ingredient_set_count).to eq 51
  	end

  	it "imports 573 ingredient_entries" do 
  		ingredient_entry_count = IngredientEntry.count
  		@importer.import
  		new_ingredient_entry_count = IngredientEntry.count - ingredient_entry_count

  		expect(new_ingredient_entry_count).to eq 572
  	end

  	it "imports 152 method steps" do 
  		method_steps_count = MethodStep.count
  		@importer.import
  		new_method_steps_count = MethodStep.count - method_steps_count

  		expect(new_method_steps_count).to eq 152
  	end  	
  end
end
