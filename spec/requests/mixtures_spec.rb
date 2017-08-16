require 'rails_helper'

RSpec.describe "Mixtures", type: :request do
  describe "GET /mixtures" do
    it "works! (now write some real specs)" do
      get mixtures_path
      expect(response).to have_http_status(200)
    end
  end
  

#from autogenerated controller spec (by scaffold)

  # This should return the minimal set of attributes required to create a valid
  # PhysicalColor. As you add validations to PhysicalColor, be sure to
  # adjust the attributes here as well.
#  let(:valid_attributes) {
#    {component_l: 50, component_a: 30, component_b: 40}
#  }
#
#  let(:invalid_attributes) {
#    {component_l: -450, component_a: 330, component_b: 240}
#  }
#  let(:valid_pigment){
#    Pigment.new(name: 'Pigment XX')
#  }
#  let(:invalid_pigment){
#    Pigment.new(name: nil)
#  }
#  let(:saved_color){
#    PhysicalColor.last
#  }
#
#  # This should return the minimal set of values that should be in the session
#  # in order to pass any filters (e.g. authentication) defined in
#  # PhysicalColorsController. Be sure to keep this updated too.
#  let(:valid_session) { {user_id: 1} }
#
#  describe "GET #index" do
#    it "returns a success response" do
#      get url_for(controller: :mixtures, action: :index)
#      expect(response).to be_success
#    end
#  end
#
#  describe "GET #show" do
#    it "returns a success response" do
#      physical_color = PhysicalColor.create! valid_attributes
#      get url_for(controller: :mixtures, action: :show, id: physical_color.to_param)
#      expect(response).to be_success
#    end
#  end
#
#  describe "POST #create" do
#    context "with valid params" do
#      it "creates a new PhysicalColor" do
#        expect {
#          post url_for(controller: :mixtures, action: :create, physical_color: valid_attributes)
#        }.to change(PhysicalColor, :count).by(1)
#      end
#
#      it "renders a JSON response with the new physical_color" do
#
#        post url_for(controller: :mixtures, action: :create, physical_color: valid_attributes)
#        expect(response).to have_http_status(:created)
#        expect(response.content_type).to eq('application/json')
#        expect(response.location).to eq(color_url(PhysicalColor.last))
#      end
#    end
#
#    context "with invalid params" do
#      it "renders a JSON response with errors for the new physical_color" do
#        post url_for(controller: :mixtures, action: :create, physical_color: invalid_attributes)
#        expect(response).to have_http_status(:unprocessable_entity)
#        expect(response.content_type).to eq('application/json')
#      end
#    end
#  end
#
#  describe "PUT #update" do
#    context "with valid params" do
#      let(:new_attributes) {
#        {component_a: 55}
#      }
#
#      it "updates the requested physical_color" do
#        physical_color = PhysicalColor.create! valid_attributes
#        put url_for(controller: :mixtures, action: :update, id: physical_color.to_param, physical_color: new_attributes)        
#        physical_color.reload
#        new_attributes.each do |attribute, value|
#          expect(physical_color.send(attribute)).to eq(value)
#        end
#      end
#
#      it "renders a JSON response with the physical_color" do
#        physical_color = PhysicalColor.create! valid_attributes
#        put url_for(controller: :mixtures, action: :update, id: physical_color.to_param, physical_color: valid_attributes)        
#        expect(response).to have_http_status(:ok)
#        expect(response.content_type).to eq('application/json')
#      end
#    end
#
#    context "with invalid params" do
#      it "renders a JSON response with errors for the physical_color" do
#        physical_color = PhysicalColor.create! valid_attributes
#        put url_for(controller: :mixtures, action: :update, id: physical_color.to_param, physical_color: invalid_attributes)
#        expect(response).to have_http_status(:unprocessable_entity)
#        expect(response.content_type).to eq('application/json')
#      end
#    end
#  end
#
#  describe "DELETE #destroy" do
#    it "destroys the requested physical_color" do
#      physical_color = PhysicalColor.create! valid_attributes
#      expect {
#        delete url_for(controller: :mixtures, action: :destroy, id: physical_color.to_param)
#      }.to change(PhysicalColor, :count).by(-1)
#    end
#  end
  
end
