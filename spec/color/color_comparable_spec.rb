require 'rails_helper'

describe ColorModule::Comparators::ColorComparable do
  estandar = [87.86, 6.15, 90.57] #lab components
  color2 = [86.89, 9.07, 87.34] #lab components
  de_cmc =  1.97  #desviacion delta E CMC
  describe '#compare_with' do 
    context 'when using default comparator (CMCComparator)'do 
      c_estandar =   ColorModule::Color.new(:LAB, *estandar)
      c2 =  ColorModule::Color.new(:LAB, *color2)
      comp =  c_estandar.compare_with(c2)
      it 'returns a ComparatorResult instance' do 
        expect(comp).to be_an_instance_of(ColorModule::Comparators::ColorComparable::ComparatorResult)
      end
      it 'returns a CMCComparator::Result in result variable' do 
        expect(comp.result).to be_a(ColorModule::Comparators::CMCComparator::Result)
      end
      it 'returns the correct answer in value' do
        expect(comp.value).to eq(de_cmc)
      end
      
    end
  end
  
end