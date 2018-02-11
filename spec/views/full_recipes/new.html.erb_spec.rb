require 'rails_helper'

RSpec.describe "full_recipes/new", type: :view do
  before(:each) do
    assign(:full_recipe, FullRecipe.new())
  end

  it "renders new full_recipe form" do
    render

    assert_select "form[action=?][method=?]", full_recipes_path, "post" do
    end
  end
end
