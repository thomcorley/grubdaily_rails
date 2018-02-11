require "rails_helper"

RSpec.describe FullRecipesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/full_recipes").to route_to("full_recipes#index")
    end

    it "routes to #new" do
      expect(:get => "/full_recipes/new").to route_to("full_recipes#new")
    end

    it "routes to #show" do
      expect(:get => "/full_recipes/1").to route_to("full_recipes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/full_recipes/1/edit").to route_to("full_recipes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/full_recipes").to route_to("full_recipes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/full_recipes/1").to route_to("full_recipes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/full_recipes/1").to route_to("full_recipes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/full_recipes/1").to route_to("full_recipes#destroy", :id => "1")
    end

  end
end
