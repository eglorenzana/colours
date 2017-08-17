require 'rails_helper'
RSpec.describe "Utilities", type: :request do
  describe "POST /utilities/converters/:from_space/:to_space" do
    space1 = :rgb
    space2= :cmyk
    params = {action: :convert_color, controller: :utilities, from_space: space1, to_space: space2}
    components = {r: 50, g: 30, b: 200}
    params.merge!({components: components})
    context 'given valid spaces'  do
      context 'when components valid in hash' do
        it "return :ok" do
          url = url_for(params.merge({components: components}))
          post url
          expect(response).to have_http_status(:ok)
        end
      end
      context 'when components valid in array'  do
        it "return :ok" do
          url = url_for(params.merge({components: components.values}))
          post url
          expect(response).to have_http_status(:ok)
        end
      end
      context 'when a component is not present' do
        it "return :bad_request " do
          url = url_for(params.merge(components: components.values[0..-2]))
          post url
          expect(response).to have_http_status(:bad_request)
        end
      end
      context 'when a component is not an array or hash, but is just a number' do
        it "return :bad_request " do
          url = url_for(params.merge({components: components.values.pop}))
          post url
          expect(response).to have_http_status(:bad_request)
        end
      end
      context 'when a component is not given' do
        it "return :bad_request " do
          url = url_for(params.merge(components: nil).compact)
          post url
          expect(response).to have_http_status(:bad_request)
          url = url_for(params.merge(components: []))
          post url
          expect(response).to have_http_status(:bad_request)
        end
      end
      context 'when request with long option' do
        skip
      end
    end

    context 'given unknown spaces' do
      it 'return :not_found' do
        url = url_for(params.merge(from_space: :abcd))
        post url
        expect(response).to have_http_status(:not_found)
      end
      it 'return :not_found' do
        url = url_for(params.merge(to_space: :abcd))
        post url
        expect(response).to have_http_status(:not_found)
      end
    end

  end

  describe "POST /utilities/comparators/:comparator" do
    space = :lab
    comparator = :cmc
    color_components1 = {l: 87.86, a: 6.15, b: 90.57} #lab components
    color_components2 = {l: 86.89, a: 9.07, b: 87.34} #lab components
    params = {action: :compare_colors, controller: :utilities, comparator: comparator, space: space}
    params.merge!({color1: color_components1, color2: color_components2})

    context 'given a valid comparator'  do
      context 'when valid space, and color components(in hash)' do
        it "return :ok" do
          context_params = {color1: color_components1, color2: color_components2 }
          url = url_for(params.merge(context_params))
          post url
          expect(response).to have_http_status(:ok)
        end
      end
      context 'when valid space, and color components(in array)' do
        context_params = params.merge({ color1: color_components1.values, color2: color_components2.values })
        it "return :ok" do
          url = url_for(context_params)
          post url
          expect(response).to have_http_status(:ok)
        end
      end
      context 'when a color component is not present' do
        context_params = { color1: color_components1.values[0..-2], color2: color_components2.values }
        it "return :bad_request" do
          url = url_for(params.merge(context_params))
          post url
          expect(response).to have_http_status(:bad_request)
        end
      end
      context 'when a color component is not an array or hash, but is just a number' do
        context_params = { color1: color_components1.values.pop, color2: color_components2.values }
        it "return :bad_request " do
          url = url_for(params.merge(context_params))
          post url
          expect(response).to have_http_status(:bad_request)
        end
      end
      context 'when a color component is not given' do
        context_params = { color1: [], color2: color_components2.values }
        it "return :bad_request " do
          url = url_for(params.merge(context_params))
          post url
          expect(response).to have_http_status(:bad_request)
        end
      end
      context 'when request with long option' do
        skip
      end

      context 'when given unknown spaces' do
        it 'return :not_found' do
          url = url_for(params.merge({space: :xxxxx}))
          post url
          expect(response).to have_http_status(:not_found)
        end
      end
    end
    context 'given an unknown comparator' do
      it 'return :not_found' do
        url = url_for(params.merge(comparator: :abcd))
        post url
        expect(response).to have_http_status(:not_found)
      end
    end

  end
end
