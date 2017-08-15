require 'rails_helper'

RSpec.describe PcPart, type: :model do
  describe '#save' do
    context 'when has NOT a valid percentage, another_color, or physical_color' do
      pc_part =  PcPart.new
      it 'is invalid to save' do
        expect(pc_part.invalid?).to be_truthy
        expect(pc_part.save).to be_falsy
      end
    end
    context 'when has valid percentage and physical_color NOT SAVED YET in db' do
      pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
      another =  PhysicalColor.new(component_l: 10, component_a: 10, component_b: 10 )
      pc_part =  PcPart.new(physical_color: pc, percentage: 50, another_color: another)
      it 'does NOT saves the PcPart' do
        expect(pc_part.save).to be_falsy
      end
    end
    context 'when has valid percentage and physical_color already saved in db' do
      pc =  PhysicalColor.new(component_l: 24, component_a: 41, component_b: 33 )
      another =  PhysicalColor.find_or_create_by(component_l: 12, component_a: 12, component_b: 81 )
      pc_part =  PcPart.new(physical_color: pc, percentage: 50, another_color: another)
      it 'saves the PcPart' do
        expect(pc_part.save).to be_truthy
      end
    end
  end
end
