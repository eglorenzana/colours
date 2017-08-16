require "rails_helper"

RSpec.describe PhysicalColorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/physical_colors").to route_to("physical_colors#index")
    end


    it "routes to #show" do
      expect(:get => "/physical_colors/1").to route_to("physical_colors#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/physical_colors").to route_to("physical_colors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/physical_colors/1").to route_to("physical_colors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/physical_colors/1").to route_to("physical_colors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/physical_colors/1").to route_to("physical_colors#destroy", :id => "1")
    end

  end
end
