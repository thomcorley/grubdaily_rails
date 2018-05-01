require 'rails_helper'

RSpec.describe IngredientEntry, type: :model do
  context "upon creation" do
    setup do
      @ingredient_entry = FactoryBot.build :ingredient_entry
    end

    it "should have a lower case modifier" do
      m = @ingredient_entry.modifier
      expect(m.downcase).to eq m
    end
  end
end
