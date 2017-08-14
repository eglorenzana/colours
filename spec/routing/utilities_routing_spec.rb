require "rails_helper"

RSpec.describe UtilitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/utilities").to route_to("utilities#index")
    end
    it "routes to #convert_color" do
      expect(:post => "/utilities/converters/rgb/cmyk").to route_to("utilities#convert_color", from_space: 'rgb', to_space: 'cmyk')
    end
    it "routes to #compare_colors" do
      expect(:post => "/utilities/comparators/cmc").to route_to("utilities#compare_colors", comparator: 'cmc')
    end


    it "routes to #show" do
      expect(:get => "/utilities/1").not_to route_to("utilities#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/utilities").not_to route_to("utilities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/utilities/1").not_to route_to("utilities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/utilities/1").not_to route_to("utilities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/utilities/1").not_to route_to("utilities#destroy", :id => "1")
    end

  end
end
