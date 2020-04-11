require 'rails_helper'

RSpec.describe RecipeImporter, type: :model do
	setup do
    content = File.read("lib/yaml_recipes/bacon_and_pea_risotto.yaml")
		@importer = RecipeImporter.new(content)
    @importer.populate_fields
    @recipe = FactoryBot.create :recipe
	end

  context "the recipe info" do
    it "should have a title" do
      expect(@importer.title).to eq "Bacon and Pea Risotto"
    end

    it "should have a total time" do
      expect(@importer.total_time).to eq "PT45M"
    end

    it "should have a type" do
      expect(@importer.recipe_type).to eq "main"
    end

    it "should have a category" do
      expect(@importer.category).to eq "risotto"
    end

    it "should have tags" do
      expect(@importer.tags).to eq "risotto, bacon, pea, italian"
    end

    it "should have a title" do
      expect(@importer.summary.first(12)).to eq "My favourite"
    end
  end

  context "the introduction" do
  	it "should be present" do
  		expect(@importer.introduction).to be_present
  	end
  end

  context "ingredient sets" do
  	it "should be present" do
  		expect(@importer.ingredient_sets).to be_present
  	end
  end

  context "the method steps" do
  	it "should be present" do
  		expect(@importer.method_steps).to be_present
  	end
	end

  context "#save_recipe" do
    it "should save a recipe to the database" do
      before = Recipe.count
      @importer.save_recipe
      after = Recipe.count

      expect(after - before).to eq 1
    end

    it "should create a valid recipe" do
      @importer.save_recipe

      expect(Recipe.last).to be_valid
    end
  end

  context "#save_ingredients" do
    it "should save 1 ingredient set" do
      before = IngredientSet.count
      @importer.save_ingredients(@recipe.id)
      after = IngredientSet.count

      expect(after - before).to eq 1
    end

    it "should save 12 ingredient entries" do
      before = IngredientEntry.count
      @importer.save_ingredients(@recipe.id)
      after = IngredientEntry.count

      expect(after - before).to eq 12
    end

    it "should save 12 ingredients" do
      before = Ingredient.count
      @importer.save_ingredients(@recipe.id)
      after = Ingredient.count

      expect(after - before).to eq 12
    end
  end

  context "#save_method_steps" do
    it "should save 6 method steps" do
      before = MethodStep.count
      @importer.save_method_steps(@recipe.id)
      after = MethodStep.count

      expect(after - before).to eq 6
    end
  end

  context "#save_tags" do
    it "should save 4 tags" do
      before = Tag.count
      @importer.save_tags(@recipe.id)
      after = Tag.count

    expect(after - before).to eq 4
    end
  end
end
