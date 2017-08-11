require 'rails_helper'

RSpec.describe PcPigmentPart, type: :model do
  describe '#save' do
    context 'when has NOT a valid percentage, pigment or physical_color' do
      pc_pigment =  PcPigmentPart.new
      it 'is invalid to save' do
        expect(pc_pigment.invalid?).to be_truthy
        expect(pc_pigment.save).to be_falsy
      end
    end
    context 'when has valid percentage, tint and physical_color' do
      p = Pigment.create(name: 'Pigment X')      
      pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
      pc_pigment =  PcPigmentPart.new(pigment: p, physical_color: pc, percentage: 50)
      it 'saves the PcPigmentPart' do
        expect(pc_pigment.save).to be_truthy
      end
    end
  end
  
  
  describe '#kind_of' do
    context 'when includes PhysicalColorPart' do
      it 'is a PhysicalColorPart' do
        expect(PcPigmentPart.new).to be_a(PhysicalColorPart)
      end
    end
  end  
end
