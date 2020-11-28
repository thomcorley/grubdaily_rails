require "rails_helper"

RSpec.describe RecipeMailer, type: :mailer do
  let(:recipe) { FactoryBot.create(:recipe) }
  let(:email_subscriber) { EmailSubscriber.create(email: "mail@example.com") }
  let(:mail) { RecipeMailer.new_recipe(recipe: recipe, email_subscriber: email_subscriber) }

  it "has a text part body" do
    expect(mail.text_part.present?).to be_truthy
  end

  it "has an html part body" do
    expect(mail.html_part.present?).to be_truthy
  end

  it "has the expected subject" do
    expect(mail.subject).to eq("Something tasty for you: #{recipe.title}")
  end
end
