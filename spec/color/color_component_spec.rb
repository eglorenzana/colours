require 'rails_helper'

describe ColorModule::ColorComponent do
  describe "create a color component" do
    context 'when it is given a name and valid ranges' do 
      it 'returns a ColorComponent' do
        cc =  ColorModule::ColorComponent.new(:component, 0, 1)
        expect(cc).to be_an_instance_of(ColorModule::ColorComponent)
      end
    end
  end
  
  describe 'assign value to a ColorComponent' do 
    context 'when value is in valid range' do 
      it 'assign the value' do
        cc =  ColorModule::ColorComponent.new(:R, 0, 1)
        cc.value= 0.78
        expect(cc.value).to be 0.78
      end
    end    
    context 'when value is OUT of valid range' do 
      it 'raise a ColorComponentError' do
        cc =  ColorModule::ColorComponent.new(:G, 0, 1)
        expect{cc.value= 4}.to raise_error(ColorModule::ColorComponentError, /Range/)
      end
    end    
  end
  
  
end