require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context "Recipe creation" do
    setup do
      @recipe = FactoryBot.build :recipe
    end

    it "should have a valid image url, if there is an image" do
      @recipe.title = "Roast Garlic Soup"
      @recipe.save!
      expect(@recipe.image_url).to be_present
    end

    it "should be valid" do
      expect(@recipe).to be_valid
    end

    it "should have a vaild title" do
      expect(@recipe.title.length).to be < 40
      expect(@recipe.title).to be_present
    end

    it "should have a valid summary" do
      expect(@recipe.summary).to be_present
      expect(@recipe.summary.length).to be < 150
    end

    it "should have a time value in valid ISO 8601 format" do
      expect(@recipe.total_time).to match Recipe::TIME_FORMAT_REGEX
    end

    it "should have a value for either :serves or :makes" do
      @recipe.assign_attributes(serves: nil, makes: nil, makes_unit: nil)
      expect(@recipe).to be_invalid
    end

    it "should have a value for :makes_unit if :makes is present" do
      @recipe.update_attributes(serves: nil, makes: 1, makes_unit: nil)
      expect(@recipe).to be_invalid
    end

    it "should have a numerical value greater than 0 for :serves" do
      @recipe.update_attributes(serves: 1, makes: nil, makes_unit: nil)
      expect(@recipe.serves).to be > 0
    end

    it "should have a numerical value greater than 0 for :makes" do
      @recipe.update_attributes(serves: 0, makes: 0, makes_unit: "loaves")
      expect(@recipe).to be_invalid
    end

    it "should have a non-numerical value for :makes_unit" do
      expect(@recipe.makes_unit.is_a?(Numeric)).to eq false
    end
  end
end
