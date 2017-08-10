require 'rails_helper'

describe ColorModule::Spaces::ColorModel do
  describe 'create a color model instance' do 
    context 'when arguments are valid' do
      params = {name: :custom , components: [:C, :U, :S, :T, :O, :M], valid_ranges: []}
      6.times{ params[:valid_ranges] << [0, 100] }  #it must be the same size of the components
      cc = ColorModule::Spaces::ColorModel.new(params)
      it 'is an instance of color model' do
        expect(cc).to be_an_instance_of(ColorModule::Spaces::ColorModel)
      end
      it 'has a custom model_name' do
        expect(cc.model_name).to be params[:name]
      end
      it 'has the correct number of components' do
        expect(cc.components.size).to eq(params[:valid_ranges].size)
      end
      it 'has the correct component names' do
        expect(cc.component_names).to eq(params[:components])
      end
    end
    context 'when number of arguments are not valid' do 
      params = {name: :custom , valid_ranges: []}
      it 'raise a ColorModelError' do 
        expect{ColorModule::Spaces::ColorModel.new(params)}.
          to raise_error(ColorModule::Spaces::ColorModelError, /Argument/)
      end
    end
    context 'when components and valid_ranges are not the same size' do 
      params = {name: :custom , components: [:C, :U, :S, :T, :O, :M], valid_ranges: []}
      3.times{ params[:valid_ranges] << [0, 100] }  #it must be the same size of the components
      it 'raise a ColorModelError' do 
        expect{ColorModule::Spaces::ColorModel.new(params)}.
          to raise_error(ColorModule::Spaces::ColorModelError, /Size/)
      end
    end
  end
  
  
  describe '#assign_components' do 
    params = {name: :custom , components: [:C, :U, :S, :T, :O, :M], valid_ranges: []}
    6.times{ params[:valid_ranges] << [0, 100] }
    cc = ColorModule::Spaces::ColorModel.new(params)
    context 'when components values are valid' do 
      it 'assigns the components values' do
        values = [50, 50, 40, 30, 90, 70] 
        cc.assign_components(*values)
        expect(cc.component_values).to eq values 
      end
    end
    context 'when components values are OUT of valid range' do 
      it 'assigns the components values' do
        values = [20, 400, 300, 1000, 4 ] 
        expect{cc.assign_components(*values)}.to raise_error(ColorModule::ColorComponentError, /Range/)
      end
    end
  end
  
end