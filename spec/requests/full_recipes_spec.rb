require 'rails_helper'

RSpec.describe "FullRecipes", type: :request do
  describe "GET /full_recipes" do
    it "works! (now write some real specs)" do
      get full_recipes_path
      expect(response).to have_http_status(200)
    end
  end
end
