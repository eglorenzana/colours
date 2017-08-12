require 'rails_helper'

RSpec.describe PhysicalColor, type: :model do
  describe '#save' do
    context 'when has NOT all components' do
      pc =  PhysicalColor.new
      it 'is invalid' do
        expect(pc.invalid?).to be_truthy
        expect(pc.save).to be_falsy
      end
    end
    context 'when has all components but some invalid' do
      pc =  PhysicalColor.new(component_l: -350, component_a: 400, component_b: 320 )
      it 'is invalid' do
        expect(pc.invalid?).to be_truthy
        expect(pc.save).to be_falsy
      end
    end
    context 'when has all components valid' do
      pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
      it 'saves the PhysicalColor' do
        expect(pc.valid?).to be_truthy 
        expect(pc.save).to be_truthy 
      end
    end
  end
  
  describe 'associations' do
    context 'when has associations with his parts' do 
      it 'responds to white_base_parts' do 
        expect(PhysicalColor.new).to respond_to(:white_base_parts)
      end
      it 'responds to pigment_parts' do 
        expect(PhysicalColor.new).to respond_to(:pigment_parts)
      end
      it 'responds to tint_parts' do 
        expect(PhysicalColor.new).to respond_to(:tint_parts)
      end
      it 'responds to physical_color_parts' do 
        expect(PhysicalColor.new).to respond_to(:another_color_parts)
      end
    end
  end
  
  describe '.kind_of' do
    context 'when extends Partitionable' do
      it 'is a Partitionable' do
        expect(PhysicalColor).to be_a(Partitionable)
      end
    end
  end
  
end
