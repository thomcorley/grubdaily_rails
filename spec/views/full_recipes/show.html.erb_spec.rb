require 'rails_helper'

RSpec.describe "full_recipes/show", type: :view do
  before(:each) do
    @full_recipe = assign(:full_recipe, FullRecipe.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
