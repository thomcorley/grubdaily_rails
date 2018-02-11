require 'rails_helper'

RSpec.describe "full_recipes/edit", type: :view do
  before(:each) do
    @full_recipe = assign(:full_recipe, FullRecipe.create!())
  end

  it "renders the edit full_recipe form" do
    render

    assert_select "form[action=?][method=?]", full_recipe_path(@full_recipe), "post" do
    end
  end
end
