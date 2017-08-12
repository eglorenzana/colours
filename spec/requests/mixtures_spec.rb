require 'rails_helper'

RSpec.describe "Mixtures", type: :request do
  describe "GET /mixtures" do
    it "works! (now write some real specs)" do
      get mixtures_path
      expect(response).to have_http_status(200)
    end
  end
end
