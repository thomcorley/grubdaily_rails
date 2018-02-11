require 'rails_helper'

RSpec.describe "full_recipes/index", type: :view do
  before(:each) do
    assign(:full_recipes, [
      FullRecipe.create!(),
      FullRecipe.create!()
    ])
  end

  it "renders a list of full_recipes" do
    render
  end
end
