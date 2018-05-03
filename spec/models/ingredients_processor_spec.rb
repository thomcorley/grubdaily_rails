require 'rails_helper'

RSpec.describe RecipeImporter, type: :model do
	setup do
		ingredient_sets = [{:INSERT_TITLE=>["140g risotto rice", "1 small onion, finely chopped", "2 cloves garlic, finely chopped", "1 glassful dry white wine", "60g parmesan cheese, finely grated", "40g unsalted butter, chopped", "1 tablespoon extra virgin olive oil", "sea salt and freshly cracked black pepper", "200g garden peas, fresh or frozen", "150g streaky bacon, cut into lardons", "1 litre chicken stock", "vegetable oil, for frying"]}, nil, nil]
		@processor = IngredientsProcessor.new(ingredient_sets)
	end

  context "#params_for_ingredient_sets" do
    it "should return an array" do
      expect(@processor.params_for_ingredient_sets(5)).to be_a Array
    end

    it "should return an array of hashes with keys :title, :position, :recipe_id" do
      ingredient_set = @processor.params_for_ingredient_sets(5).first
      keys = @processor.params_for_ingredient_sets(5).first.keys

      expect(ingredient_set).to be_a Hash
      expect(keys).to eq [:title, :position, :recipe_id]
    end
  end

  context "#parse_ingredient_entry" do

    context "parsing '1 carrot'" do
      it "should have a quantity of 1" do
        expect(@processor.quantity("1 carrot")).to eq 1
      end

      it "should have a quantity of 1" do
        expect(@processor.quantity("1 carrot")).to eq 1
      end

    end
  end
end