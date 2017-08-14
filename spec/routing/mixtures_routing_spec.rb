require "rails_helper"

RSpec.describe MixturesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/colors").to route_to("physical_colors#index")
    end


    it "routes to #show" do
      expect(:get => "/colors/1").to route_to("physical_colors#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/colors").to route_to("physical_colors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/colors/1").to route_to("physical_colors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/colors/1").to route_to("physical_colors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/colors/1").to route_to("physical_colors#destroy", :id => "1")
    end

  end
end
