require "rails_helper"

RSpec.describe PigmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pigments").to route_to("pigments#index")
    end


    it "routes to #show" do
      expect(:get => "/pigments/1").to route_to("pigments#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/pigments").to route_to("pigments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pigments/1").to route_to("pigments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pigments/1").to route_to("pigments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pigments/1").to route_to("pigments#destroy", :id => "1")
    end

  end
end
