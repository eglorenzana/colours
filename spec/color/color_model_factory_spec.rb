require 'rails_helper'

describe ColorModule::Spaces::ColorModelFactory do
  describe ".get_model" do
    context 'when the model exists' do 
#      class << ColorModule::Spaces
#        class CustomModel < ColorModule::Spaces::ColorModel
#          
#        end
#      end
      name = 'RGB'
      model_class =  ColorModule::Spaces::RGBModel
      it 'returns an intance of the model' do  
        expect(ColorModule::Spaces::ColorModelFactory.get_model(name)).
          to be_an_instance_of(model_class)
      end
    end
    
    context 'when the model does not exist' do
      name = 'Unkown'
      it 'raise a ColorModelError' do
        expect{ColorModule::Spaces::ColorModelFactory.get_model(name)}.
          to raise_error(ColorModule::Spaces::ColorModelError, /named/)
      end
    end
  end
    
  
end