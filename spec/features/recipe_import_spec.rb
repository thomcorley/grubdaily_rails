# frozen_string_literal: true
require "rails_helper"

RSpec.feature "Recipe Import" do
  scenario "Importing a recipe with a YAML file" do
    visit "recipe_imports/new"

    yaml_content = File.read("spec/test_data/benchmark_test_recipe.yaml")

    fill_in("Content", with: yaml_content)
    click_button("Create!")

    expect(page).to have_text("This is my _favourite_ pancakes recipe in the world")
    expect(page).to have_text("34 large onions, finely chopped")
    expect(page).to have_text("2 x 400g tins tomatoes")

    click_link("Edit Recipe")

    expect(page).to have_field("recipe_title", with: "Best Ever Random Pancakes")
    expect(page).to have_field("recipe_tags", with: "pancakes, British, tasty brunch, delicious")
    expect(page).to have_field("recipe_type", with: "brunch")
    expect(page).to have_field("recipe_makes", with: "45")
    expect(page).to have_field("recipe_makes_unit", with: "pancakes")
    expect(page).to have_field("recipe_total_time", with: "PT2D4H23M")

    expect(find("input#recipe_serves")["value"]).to be nil
  end
end
