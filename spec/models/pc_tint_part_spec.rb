require 'rails_helper'

RSpec.describe PcTintPart, type: :model do
  describe '#save' do
    context 'when has NOT a valid percentage, tint or physical_color' do
      pc_tint =  PcTintPart.new
      it 'is invalid to save' do
        expect(pc_tint.invalid?).to be_truthy
        expect(pc_tint.save).to be_falsy
      end
    end
    context 'when has valid percentage, tint and physical_color' do
      t = Tint.create(name: 'Tint X')      
      pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
      pc_tint =  PcTintPart.new(tint: t, physical_color: pc, percentage: 50)
      it 'saves the PcTintPart' do
        expect(pc_tint.save).to be_truthy
      end
    end
  end
  
  describe '#kind_of' do
    context 'when includes PhysicalColorPart' do
      it 'is a PhysicalColorPart' do
        expect(PcTintPart.new).to be_a(PhysicalColorPart)
      end
    end
  end  
end
