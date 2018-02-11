require 'rails_helper'

RSpec.describe IngredientSet, type: :model do
  context "ingredient set creation" do
    setup do
      @ingredient_set = FactoryBot.build :ingredient_set
    end

    it "should have a title of maximum 30 characters length" do
      @ingredient_set.title += "a" * 30
      expect(@ingredient_set).to be_invalid
    end
  end
end
