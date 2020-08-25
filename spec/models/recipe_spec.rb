require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context "Recipe creation" do
    let(:recipe) { FactoryBot.build(:recipe) }

    it "should have a valid image url, if there is an image" do
      fake_response = double("Response", code: 200)
      allow(HTTParty).to receive(:get).and_return(fake_response)

      recipe.title = "Roast Garlic Soup"
      recipe.save!
      expect(recipe.image_url).to be_present
    end

    it "should have a vaild title" do
      expect(recipe.title.length).to be < 40
      expect(recipe.title).to be_present
    end

    it "should have a valid summary" do
      expect(recipe.summary).to be_present
      expect(recipe.summary.length).to be < 150
    end

    it "should have a time value in valid ISO 8601 format" do
      expect(recipe.total_time).to match Recipe::TIME_FORMAT_REGEX
    end

    it "should have a value for either :serves or :makes" do
      recipe.assign_attributes(serves: nil, makes: nil, makes_unit: nil)
      expect(recipe).to be_invalid
    end

    it "should have a value for :makes_unit if :makes is present" do
      recipe.update(serves: nil, makes: 1, makes_unit: nil)
      expect(recipe).to be_invalid
    end

    it "should have a numerical value greater than 0 for :serves" do
      recipe.update(**{serves: 1, makes: nil, makes_unit: nil})
      expect(recipe.serves).to be > 0
    end

    it "should have a numerical value greater than 0 for :makes" do
      attrs = { serves: 0, makes: 0, makes_unit: "loaves" }
      recipe.update(**attrs)
      expect(recipe).to be_invalid
    end

    it "should have a non-numerical value for :makes_unit" do
      expect(recipe.makes_unit.is_a?(Numeric)).to eq false
    end

    describe "#json_schema" do
      let(:recipe) { FactoryBot.create(:recipe) }
      let(:parsed_json) { JSON.parse(recipe.json_schema) }

      it "generates valid json" do
        expect(parsed_json).to be_truthy
      end

      it "has the correct keys" do
        expected_keys = ["@context", "@type", "name", "author", "image"]
        actual_keys = parsed_json.keys.first(5)

        expect(expected_keys).to eq actual_keys
      end

      context "ingredients and method steps" do
        before(:each) do
          ingredient_set = FactoryBot.create(:ingredient_set, recipe: recipe)
          FactoryBot.create_list(:ingredient_entry, 2, ingredient_set: ingredient_set)
          FactoryBot.create_list(:method_step, 2, recipe: recipe)
          recipe.reload
        end

        it "contains correct ingredients" do
          parsed_ingredients = parsed_json["recipeIngredient"]
          expected_ingredients = [
            "10 g carrot, finely chopped",
            "10 g carrot, finely chopped"
          ]

          expected_ingredients.each do |ingredient|
            expect(parsed_ingredients).to include(ingredient)
          end
        end

        it "contains correct method steps" do
          parsed_method_steps = parsed_json["recipeInstructions"]
          expected_method_steps = [
            "Peel and finely chop the onions",
            "Peel and finely chop the onions"
          ]

          expected_method_steps.each do |method_step|
            expect(parsed_method_steps).to include(method_step)
          end
        end
      end
    end
  end
end
