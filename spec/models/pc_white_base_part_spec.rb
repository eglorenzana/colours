require 'rails_helper'

RSpec.describe PcWhiteBasePart, type: :model do
  describe '#save' do
    context 'when has NOT a valid percentage, base or physical_color' do
      pc_base =  PcWhiteBasePart.new
      it 'is invalid to save' do
        expect(pc_base.invalid?).to be_truthy
        expect(pc_base.save).to be_falsy
      end
    end
    context 'when has valid percentage, base and physical_color' do
      b = WhiteBase.create(name: 'Base X')      
      pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
      pc_base =  PcWhiteBasePart.new(white_base: b, physical_color: pc, percentage: 50)
      it 'saves the PcWhiteBasePart' do
        expect(pc_base.save).to be_truthy
      end
    end
  end
  
  describe '#kind_of' do
    context 'when includes PhysicalColorPart' do
      it 'is a PhysicalColorPart' do
        expect(PcWhiteBasePart.new).to be_a(PhysicalColorPart)
      end
    end
  end
end
