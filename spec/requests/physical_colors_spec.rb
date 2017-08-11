require 'rails_helper'

RSpec.describe "PhysicalColors", type: :request do
  describe "GET /physical_colors" do
    it "works! (now write some real specs)" do
      get physical_colors_path
      expect(response).to have_http_status(200)
    end
  end
end
