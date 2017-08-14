require "rails_helper"

RSpec.describe WhiteBasesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/white_bases").to route_to("white_bases#index")
    end


    it "routes to #show" do
      expect(:get => "/white_bases/1").to route_to("white_bases#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/white_bases").to route_to("white_bases#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/white_bases/1").to route_to("white_bases#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/white_bases/1").to route_to("white_bases#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/white_bases/1").to route_to("white_bases#destroy", :id => "1")
    end

  end
end
