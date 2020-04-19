require 'rails_helper'

RSpec.describe LegacyCsv::Importer, type: :model do
  context "#import" do
  	setup do
      names = %w(2009-12-25-tomato-and-courgette-gratin.md)

      params = {
        path: "spec/test_data/csv",
        selected_recipe_ids: ["1"],
        filenames: names,
      }

  		@importer = LegacyCsv::Importer.new(params)

      recipe_info = {
        id: "1",
        title: "Tomato and Courgette Gratin",
        introduction:  "Test introduction",
        serves: "3",
        makes: "-",
        category: "courgette",
        tags: "courgette tomato gratin",
        difficulty: "easy"
      }

      ingredients = [
        {
          id: "1",
          quantity: "3",
          unit: nil,
          size: "large",
          modifier: nil,
          ingredient: "tomatoes",
          preparation: "sliced",
          il: nil,
          original_string: "3  tomatoes, sliced"
        }
      ]

      method_steps = [ {number: "1", step: "Some instructions" } ]

      allow_any_instance_of(LegacyCsv::Formatter).to receive(:get_recipe_info).and_return(recipe_info)
      allow_any_instance_of(LegacyCsv::Formatter).to receive(:get_ingredients).and_return(ingredients)
      allow_any_instance_of(LegacyCsv::Formatter).to receive(:get_method_steps).and_return(method_steps)
  	end

  	it "imports the correct number of recipes" do
      expect{ @importer.import }.to change{ Recipe.count }.by(1)
  	end

  	it "imports the correct number of ingredient sets" do
      expect{ @importer.import }.to change{ IngredientSet.count }.by(1)
  	end

  	it "imports the correct number of ingredients" do
      expect{ @importer.import }.to change{ Ingredient.count }.by(1)
  	end

  	it "imports the correct number of method steps" do
      expect{ @importer.import }.to change{ MethodStep.count }.by(1)
  	end
  end
end
