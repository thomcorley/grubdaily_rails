require "rails_helper"

RSpec.describe RecipesController do
  describe "GET #publish" do
    let(:recipe) { FactoryBot.create(:recipe) }

    it "assigns @recipe" do
      get :publish, params: { id: recipe.id }
      expect(response).to have_http_status(:found)
      expect(assigns(:recipe)).to eq(recipe)
    end

    it "sets `published_at` on the recipe" do
      get :publish, params: { id: recipe.id }
      expect(assigns(:recipe).published_at).to be_present
    end

    context "email marketing" do
      it "sends an email" do
        expect(RecipeMailer).to receive(:new_recipe).and_call_original
        get :publish, params: { id: recipe.id }
      end
    end
  end
end
