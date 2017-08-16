require "rails_helper"

RSpec.describe TintsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tints").to route_to("tints#index")
    end


    it "routes to #show" do
      expect(:get => "/tints/1").to route_to("tints#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/tints").to route_to("tints#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tints/1").to route_to("tints#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tints/1").to route_to("tints#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tints/1").to route_to("tints#destroy", :id => "1")
    end

  end
end
