require 'rails_helper'

RSpec.describe IngredientEntryProcessor, type: :model do

  context "parsing '1 carrot'" do
    setup do
      @processor = IngredientEntryProcessor.new("1 carrot", 1)
    end

    it "has a quantity of 1" do
      expect(@processor.quantity).to eq 1
    end

    it "has a unit of nil" do
      expect(@processor.unit).to be_nil
    end

    it "has a size of nil" do
      expect(@processor.size).to be_nil
    end

    it "has a modifier of nil" do
      expect(@processor.modifier).to be_nil
    end

    it "has an ingredient of carrot" do
      expect(@processor.ingredient).to eq "carrot"
    end
  end

  context "parsing '10g carrots, diced'", :focus do
    setup do
      @processor = IngredientEntryProcessor.new("10g carrots, diced", 1)
    end

    it "has a quantity of 10" do
      expect(@processor.quantity).to eq 10
    end

    it "has a unit of 'g'" do
      expect(@processor.unit).to eq "g"
    end

    it "has a size of nil" do
      expect(@processor.size).to be_nil
    end

    it "has a modifier of 'diced'" do
      expect(@processor.modifier).to eq "diced"
    end

    it "has an ingredient of carrot" do
      expect(@processor.ingredient).to eq "carrot"
    end
  end

  context "parsing '25 large tomatoes, peeled and chopped'", :focus do
    setup do
      @processor = IngredientEntryProcessor.new("25 large tomatoes, peeled and chopped", 1)
    end

    it "has a quantity of 25" do
      expect(@processor.quantity).to eq 25
    end

    it "has a unit of nil" do
      expect(@processor.unit).to be_nil
    end

    it "has a size of 'large'" do
      expect(@processor.size).to eq "large"
    end

    it "has a modifier of 'peeled and chopped'" do
      expect(@processor.modifier).to eq "peeled and chopped"
    end

    it "has an ingredient of tomato" do
      expect(@processor.ingredient).to eq "tomato"
    end
  end

  context "parsing '3 handfuls basil, leaves picked'" do
    setup do
      @processor = IngredientEntryProcessor.new("3 handfuls basil, leaves picked", 1)
    end

    it "has a quantity of 3" do
      expect(@processor.quantity).to eq 3
    end

    it "has a unit of 'handful'" do
      expect(@processor.unit).to eq "handful"
    end

    it "has a size of nil" do
      expect(@processor.size).to be_nil
    end

    it "has a modifier of 'leaves picked'" do
      expect(@processor.modifier).to "leaves picked"
    end

    it "has an ingredient of 'basil" do
      expect(@processor.ingredient).to eq "basil"
    end
  end

  context "parsing '3 large cloves garlic, chopped'" do
    setup do
      @processor = IngredientEntryProcessor.new("3 large cloves garlic, chopped", 1)
    end

    it "has a quantity of 3" do
      expect(@processor.quantity).to eq 3
    end

    it "has a unit of 'large clove" do
      expect(@processor.unit).to eq "large clove"
    end

    it "has a size of nil" do
      expect(@processor.size).to be_nil
    end

    it "has a modifier of 'chopped'" do
      expect(@processor.modifier).to "chopped"
    end

    it "has an ingredient of 'garlic" do
      expect(@processor.ingredient).to eq "garlic"
    end
  end

  context "parsing 'a generous pinch of salt'" do
    setup do
      @processor = IngredientEntryProcessor.new("a generous pinch of salt", 1)
    end

    it "has a quantity of 1" do
      expect(@processor.quantity).to eq 1
    end

    it "has a unit of 'generous pinch" do
      expect(@processor.unit).to eq "generous pinch"
    end

    it "has a size of nil" do
      expect(@processor.size).to be_nil
    end

    it "has a modifier of nil" do
      expect(@processor.modifier).to be_nil
    end

    it "has an ingredient of 'salt'" do
      expect(@processor.ingredient).to eq "salt"
    end
  end

  context "parsing 'vegetable oil, for frying'" do
    setup do
      @processor = IngredientEntryProcessor.new("vegetable oil, for frying", 1)
    end

    it "has a quantity of nil" do
      expect(@processor.quantity).to be_nil
    end

    it "has a unit of nil" do
      expect(@processor.unit).to be_nil
    end

    it "has a size of nil" do
      expect(@processor.size).to be_nil
    end

    it "has a modifier of 'for frying'" do
      expect(@processor.modifier).to eq "for frying"
    end

    it "has an ingredient of 'vegetable oil'" do
      expect(@processor.ingredient).to eq "vegetable oil"
    end
  end

  context "parsing '2 small cloves of garlic'" do
    setup do
      @processor = IngredientEntryProcessor.new("2 small cloves of garlic", 1)
    end

    it "has a quantity of 2" do
      expect(@processor.quantity).to eq 2
    end

    it "has a unit of 'small clove'" do
      expect(@processor.unit).to eq "small clove"
    end

    it "has a size of nil" do
      expect(@processor.size).to be_nil
    end

    it "has a modifier of nil" do
      expect(@processor.modifier).to be_nil
    end

    it "has an ingredient of 'garlic'" do
      expect(@processor.ingredient).to eq "garlic"
    end
  end

  context "parsing '750g cavolo nero (black kale)'" do
    setup do
      @processor = IngredientEntryProcessor.new("750g cavolo nero (black kale)", 1)
    end

    it "has a quantity of 750" do
      expect(@processor.quantity).to eq 750
    end

    it "has a unit of 'g'" do
      expect(@processor.unit).to eq "g"
    end

    it "has a size of nil" do
      expect(@processor.size).to be_nil
    end

    it "has a modifier of '(black kale)'" do
      expect(@processor.modifier).to be_nil
    end

    it "has an ingredient of 'cavolo nero'" do
      expect(@processor.ingredient).to eq "cavolo nero"
    end
  end  
end