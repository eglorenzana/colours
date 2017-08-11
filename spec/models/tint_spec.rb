require 'rails_helper'

RSpec.describe Tint, type: :model do
  describe '#save' do
    context 'when has NOT a name' do
      b =  Tint.new
      it 'is invalid' do
        expect(b.invalid?).to be_truthy
        expect(b.save).to be_falsy
      end
    end
    context 'when has a name' do
      b =  Tint.new(name: 'Tint 1')
      it 'saves the tint' do
        expect(b.valid?).to be_truthy 
        expect(b.save).to be_truthy 
      end
    end
  end
end
