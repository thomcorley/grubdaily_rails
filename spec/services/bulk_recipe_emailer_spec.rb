require "rails_helper"

RSpec.describe BulkRecipeEmailer, type: :model do
  describe "#deliver_email_update" do
    let!(:email_subscriber) { EmailSubscriber.create(email: "mail@example.com") }
    let(:recipe) { FactoryBot.create(:recipe) }

     it "calls RecipeMailer" do
      expect(RecipeMailer).to receive(:new_recipe)
        .with(recipe: recipe, email_subscriber: email_subscriber)
        .once.and_call_original

      described_class.deliver_email_update(recipe)
    end
  end
end
