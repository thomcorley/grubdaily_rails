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
      # let(:email_subscriber) { EmailSubscriber.create!(email: "mail@example.com")  }

      it "sends an email" do
        expect(BulkRecipeEmailer).to receive(:deliver_email_update)
        get :publish, params: { id: recipe.id }
      end
    end
  end
end
