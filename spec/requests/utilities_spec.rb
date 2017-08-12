require 'rails_helper'
RSpec.describe "Utilities", type: :request do
  describe "GET /utilities" do
    it "works! (now write some real specs)" do
      get utilities_path
      expect(response).to have_http_status(200)
    end
  end
  describe "POST /utilities/converters/:from_space/:to_space" do
    space1 = :rgb
    space2= :cmyk
    params = {action: :convert_color, controller: :utilities, from_space: space1, to_space: space2}
    context 'when given valid spaces'  do
      context 'when components valid in hash' do
        components = {r: 50, g: 30, b: 200}
        params[:components] =  components              
        it "return 200" do
          url = url_for(params)
          post url
          expect(response).to have_http_status(200)
        end        
      end
      context 'when components valid in array'  do
        components = [50, 30, 200]
        params[:components] =  components        
        it "return 200" do
          url = url_for(params)     
          post url
          expect(response).to have_http_status(200)
        end        
        components = [50, 30]
        it "(with a component not present) return 200 " do
          url = url_for(params.merge(components: components))     
          post url
          expect(response).to have_http_status(200)
        end        
      end

    end
    context 'when given unknown spaces' do
      it 'return 404' do
        url = url_for(params.merge(from_space: :xxxxx))     
        post url
        expect(response).to have_http_status(404)
      end
      it 'return 404' do
        url = url_for(params.merge(to_space: :xxxxx))     
        post url
        expect(response).to have_http_status(404)
      end
    end
    
  end
end
