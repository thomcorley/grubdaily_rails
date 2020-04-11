require 'rails_helper'

RSpec.describe LegacyCsv::Importer, type: :model do
  context "#import" do
  	setup do
      names = %w(2009-12-25-tomato-and-courgette-gratin.md 2012-02-05-tomato-caper-and-shallot-salad.md)

      params = {
        path: "spec/test_data/csv",
        selected_recipe_ids: ["1", "2"],
        filenames: names,
      }

  		@importer = LegacyCsv::Importer.new(params)
  	end

  	it "imports the correct number of recipes" do
      expect{ @importer.import }.to change{ Recipe.count }.by(2)
  	end

  	it "imports the correct number of ingredient sets" do
      expect{ @importer.import }.to change{ IngredientSet.count }.by(2)
  	end

  	it "imports the correct number of ingredients" do
      expect{ @importer.import }.to change{ Ingredient.count }.by(16)
  	end

  	it "imports the correct number of method steps" do
      expect{ @importer.import }.to change{ MethodStep.count }.by(6)
  	end
  end
end
