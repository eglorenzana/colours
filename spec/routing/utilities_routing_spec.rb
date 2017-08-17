require "rails_helper"

RSpec.describe UtilitiesController, type: :routing do
  describe "routing" do

    it "routes to #convert_color" do
      expect(:post => "/convert").to route_to("utilities#convert_color")
    end
    it "routes to #compare_colors" do
      expect(:post => "/compare").to route_to("utilities#compare_colors")
    end
  end
end
