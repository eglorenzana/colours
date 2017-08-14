require 'rails_helper'

describe ColorModule::Util do 
  describe '.get_components' do
    comp_a = [24, 60, 13]
    comp_h = {r: 24, g:60, b: 13}
    comp_a_large = comp_a + [187, 143]
    space= 'rgb'
    context 'when pass a hash' do
      it 'returns a array with the component values' do
        r = ColorModule::Util.get_components(space,comp_h.stringify_keys)
        expect(r).to match_array(comp_a)
      end
    end
    context 'when pass an array' do
      it 'returns the array with the component values' do
        r = ColorModule::Util.get_components(space,comp_a)
        expect(r).to eq(comp_a)        
      end
    end
    context 'when pass an array larger than needed' do
      it 'returns the array with the number of component values' do
        r = ColorModule::Util.get_components(space,comp_a_large)
        expect(r).to eq(comp_a)        
      end
    end
  end
  
  describe '.perform_conversion' do
    space1 = 'rgb'
    space2= 'cmyk'
    color = {'r'=>80,'g'=>50,'b'=>230}
    color_result = ColorModule::Color.new(space2, [0.6521, 0.7826, 0.0, 0.0980])
    color2 = {'r'=>87,'g'=>306,'b'=>91}
    result =  1.97
    context 'when given the correct arguments' do
      it 'return the result of compare' do
        conversion = ColorModule::Util.perform_conversion(space1, space2, color)
        expect(conversion[:color]).to eql(color_result)
        expect(conversion[:color].model_name.downcase).to eq(space2.to_sym)
      end
    end
    
    context 'when given incorrect  components (out of range)'  do
      it 'raise color component error' do
      expect{ColorModule::Util.perform_conversion(space1, space2, color2)}.to raise_error(ColorModule::ColorComponentError)
      end
    end
    
    context 'when given unknow color space'  do
      it 'raise space not found' do
      expect{ColorModule::Util.perform_conversion(space1, 'xspace', color)}.to raise_error(ColorModule::Spaces::ColorSpaceNotFound)
      end
    end    
  end
  
  describe '.perform_comparation' do
    comparator = 'cmc'
    space = 'lab'
    color1 = {'l'=>87.86,'a'=>6.15,'b'=>90.57}
    color2 = {'l'=>86.89,'a'=>9.07,'b'=>87.34}
    result =  1.97
    context 'when given the correct LAB arguments' do
      it 'return the result of compare' do
        comp_result = ColorModule::Util.perform_comparation(comparator, space, color1, color2)
        expect(comp_result.value).to eq(result)
      end
    end
    
    context 'when given incorrect  comparator'  do
      it 'raise comparatator error' do
      expect{ColorModule::Util.perform_comparation('xcomparator', space, color1, color2)}.to raise_error(ColorModule::Comparators::ColorComparatorError)
      end
    end
    
    context 'when given unknow color space'  do
      it 'raise space not found' do
      expect{ColorModule::Util.perform_comparation(comparator, 'xspace', color1, color2)}.to raise_error(ColorModule::Spaces::ColorSpaceNotFound)
      end
    end
    #    space:'rgb',color1:{'r':86.89,'g':9.07,'b':87.34},color2:{'r':87.86,'g':6.15,'b':90.57}
  end
end

