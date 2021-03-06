require 'rails_helper'

RSpec.describe "Tints", type: :request do
  describe "GET /tints" do
    it "works! (now write some real specs)" do
      get tints_path
      expect(response).to have_http_status(200)
    end
  end
  
#(COPIED from physical_colors_spec)  from autogenerated controller spec (by scaffold, was deleted in spec/controllers)

  # This should return the minimal set of attributes required to create a valid
  # Tint. As you add validations to Tint, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: 'Tint 1'}
  }

  let(:invalid_attributes) {
    {name: nil}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TintsController. Be sure to keep this updated too.
  let(:valid_session) { {user_id: 1} }

  describe "GET #index" do
    it "returns a success response" do
      tint = Tint.create! valid_attributes
      get url_for(controller: :tints, action: :index)
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      tint = Tint.create! valid_attributes
      get url_for(controller: :tints, action: :show, id: tint.to_param)
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Tint" do
        expect {
          post url_for(controller: :tints, action: :create, tint: valid_attributes)
        }.to change(Tint, :count).by(1)
      end

      it "renders a JSON response with the new tint" do

        post url_for(controller: :tints, action: :create, tint: valid_attributes)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(tint_url(Tint.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new tint" do
        post url_for(controller: :tints, action: :create, tint: invalid_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: 'Tint 456'}
      }

      it "updates the requested tint" do
        tint = Tint.create! valid_attributes
        put url_for(controller: :tints, action: :update, id: tint.to_param, tint: new_attributes)        
        tint.reload
        new_attributes.each do |attribute, value|
          expect(tint.send(attribute)).to eq(value)
        end
      end

      it "renders a JSON response with the tint" do
        tint = Tint.create! valid_attributes
        put url_for(controller: :tints, action: :update, id: tint.to_param, tint: valid_attributes)        
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the tint" do
        tint = Tint.create! valid_attributes
        put url_for(controller: :tints, action: :update, id: tint.to_param, tint: invalid_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested tint" do
      tint = Tint.create! valid_attributes
      expect {
        delete url_for(controller: :tints, action: :destroy, id: tint.to_param)
      }.to change(Tint, :count).by(-1)
    end
  end
  
end
