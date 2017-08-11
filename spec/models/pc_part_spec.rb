require 'rails_helper'

RSpec.describe PcPart, type: :model do
  describe '#save' do
    context 'when has NOT a valid percentage or physical_color' do
      pc_part =  PcPart.new
      it 'is invalid to save' do
        expect(pc_part.invalid?).to be_truthy
        expect(pc_part.save).to be_falsy
      end
    end
    context 'when has valid percentage and physical_color' do
      pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
      pc_part =  PcPart.new(physical_color: pc, percentage: 50)
      it 'saves the PcPart' do
        expect(pc_part.save).to be_truthy
      end
    end
  end
  
  
  describe '#kind_of' do
    context 'when includes PhysicalColorPart' do
      it 'is a PhysicalColorPart' do
        expect(PcPart.new).to be_a(PhysicalColorPart)
      end
    end
  end  
end
