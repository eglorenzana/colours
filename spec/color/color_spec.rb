require 'rails_helper'

describe ColorModule::Color do
  describe '#new' do
    context 'create a new RGB Color' do 
      it 'returns a Color with ColorModel RGBModel' do
        c =  ColorModule::Color.new(:RGB)
        expect(c).to be_an_instance_of(ColorModule::Color)
        expect(c.model).to be_an_instance_of(ColorModule::Spaces::RGBModel)
      end
    end
    
    context 'create a new Lab Color' do 
      it 'returns a Color with ColorModel LabModel' do
        c =  ColorModule::Color.new(:LAB)
        expect(c).to be_an_instance_of(ColorModule::Color)
        expect(c.model).to be_an_instance_of(ColorModule::Spaces::LABModel)
      end
    end
    
    context 'create a new XYZ Color' do 
      it 'returns a Color with ColorModel XYZModel' do
        c =  ColorModule::Color.new(:XYZ)
        expect(c).to be_an_instance_of(ColorModule::Color)
        expect(c.model).to be_an_instance_of(ColorModule::Spaces::XYZModel)
      end
    end
    
    context 'create a new CMYK Color' do 
      it 'returns a Color with ColorModel CMYKModel' do
        c =  ColorModule::Color.new(:CMYK)
        expect(c).to be_an_instance_of(ColorModule::Color)
        expect(c.model).to be_an_instance_of(ColorModule::Spaces::CMYKModel)
      end
    end
    
  end
  
  describe '#assign_components' do 
    context 'when components values are valid' do 
      c =  ColorModule::Color.new(:RGB)
      it 'assigns the components values' do
        values = [200, 180, 5] 
        c.assign_components(*values)
        expect(c.model.component_values).to eq values 
      end
    end
    
    context 'when components values are OUT of valid range' do 
      c =  ColorModule::Color.new(:RGB)
      it 'assigns the components values' do
        values = [200, 310, 5] 
        expect{c.assign_components(*values)}.to raise_error(ColorModule::ColorComponentError)
      end
    end
  end
  
end