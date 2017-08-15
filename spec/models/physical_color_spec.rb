require 'rails_helper'

RSpec.describe PhysicalColor, type: :model do
  let(:klass){ PhysicalColor}
  let(:valid_attributes) {
    {component_l: 50, component_a: 30, component_b: 40}
  }
  
  let(:invalid_attributes) {
    {component_l: 45, component_a: 330, component_b: 240}
  }  
  describe '#save' do
    context 'when has NOT attributes' do
      it 'is invalid' do
        pc =  klass.new
        expect(pc.invalid?).to be_truthy
        expect(pc.save).to be_falsy
      end
    end
    context 'when has all components but some invalid' do
      it 'is invalid' do
        pc =  klass.new(invalid_attributes )
        expect(pc.invalid?).to be_truthy
        expect(pc.save).to be_falsy
      end
    end
    context 'when has all components valid' do
      it 'saves the PhysicalColor' do
        pc =  klass.new(valid_attributes )
        expect(pc.valid?).to be_truthy 
        expect(pc.save).to be_truthy 
      end
    end
  end
  
  describe 'associations' do
    context 'when has associations with his parts' do 
      it 'responds to white_base_parts' do 
        expect(klass.new).to respond_to(:white_base_parts)
      end
      it 'responds to pigment_parts' do 
        expect(klass.new).to respond_to(:pigment_parts)
      end
      it 'responds to tint_parts' do 
        expect(klass.new).to respond_to(:tint_parts)
      end
      it 'responds to physical_color_parts' do 
        expect(klass.new).to respond_to(:another_color_parts)
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
  
  describe '#save with Partitionable data' do
    let(:valid_pigment){
      Pigment.new(name: 'Pigment XX')
    }
    let(:invalid_pigment){
      Pigment.new(name: nil)
    }
    let(:valid_tint){
      Tint.new(name: 'Tint YY')
    }
    let(:invalid_tint){
      Tint.new(name: nil)
    }
    let(:valid_white_base){
      WhiteBase.new(name: 'White Base WW')
    }
    let(:invalid_white_base){
      WhiteBase.new(name: nil)
    }
    context 'when has NO PARTS' do 
      it 'saves the record if it is valid' do 
        pc =  klass.new(valid_attributes)
        expect(pc.valid?).to be_truthy 
        expect(pc.save).to be_truthy 
      end
    end
    context 'when has parts: pigments, tints and white_bases' do 
      context  'not valid' do
        it 'does NOT save the record neither its parts' do
          pc =  klass.new(valid_attributes)
          pc.add_part(invalid_pigment, 100)
          expect(pc.parts).to include(invalid_pigment)
          expect(pc.save).to be_falsy
          expect(Pigment.where(invalid_pigment.attributes)).not_to  exist
          expect(PcPigmentPart.where(pigment: invalid_pigment, percentage: 100)).not_to exist
        end
      end
      context 'valid' do
        context 'and percentage sum of all parts is less than 100' do
          it 'DOES NOT SAVE the record and its parts' do
            pc =  klass.new(valid_attributes)
            pc.add_part(valid_white_base, 40)
            pc.add_part(valid_pigment, 30)
            expect(pc.parts).to match_array([valid_pigment, valid_white_base])
            expect(pc.save).to be_falsy
            expect(WhiteBase.where(valid_white_base.attributes)).not_to  exist
            expect(Pigment.where(valid_pigment.attributes)).not_to  exist
            expect(PcWhiteBasePart.where(white_base: valid_white_base, percentage: 40)).not_to exist            
            expect(PcPigmentPart.where(pigment: valid_pigment, percentage: 30)).not_to exist            
          end
        end
        context 'and percentage sum of all parts reach 100' do
          it 'save the record and its parts' do
            pc =  klass.new(valid_attributes)
            pc.add_part(valid_white_base, 40)
            pc.add_part(valid_pigment, 30)
            pc.add_part(valid_tint, 30)
            expect(pc.parts).to match_array([valid_pigment, valid_tint, valid_white_base])
            expect(pc.save).to be_truthy
            expect(WhiteBase.where(valid_white_base.attributes)).to  exist
            expect(Pigment.where(valid_pigment.attributes)).to  exist
            expect(Tint.where(valid_tint.attributes)).to  exist
            expect(PcWhiteBasePart.where(white_base: valid_white_base, percentage: 40)).to exist            
            expect(PcPigmentPart.where(pigment: valid_pigment, percentage: 30)).to exist            
            expect(PcTintPart.where(tint: valid_tint, percentage: 30)).to exist            
          end
        end
      end
    end
    context 'when has parts, including physical_colors too (as another_color)' do           

      context 'valid' do
        context 'and percentage sum of all parts is less than 100' do
          let(:another_color){
            PhysicalColor.new(name: 'Blue Shadowize 23', component_l: 30, component_a: 40, component_b: 60)
          }            
          it 'DOES NOT SAVE the record and its parts' do
            pc =  klass.new(valid_attributes)
            pc.add_part(valid_white_base, 40)
            pc.add_part(valid_pigment, 30)
            pc.add_part(another_color, 20)
            expect(pc.parts).to match_array([valid_pigment, valid_white_base, another_color])
            expect(pc.save).to be_falsy
            expect(WhiteBase.where(valid_white_base.attributes)).not_to  exist
            expect(Pigment.where(valid_pigment.attributes)).not_to  exist
            expect(PhysicalColor.where(another_color.attributes)).not_to  exist
            expect(PcWhiteBasePart.where(white_base: valid_white_base, percentage: 40)).not_to exist            
            expect(PcPigmentPart.where(pigment: valid_pigment, percentage: 30)).not_to exist            
            expect(PcPart.where(another_color: another_color, percentage: 20)).not_to exist            
          end
        end
        context 'and percentage sum of all parts reach 100' do
          let(:another_color2){
            PhysicalColor.new(name: 'Red F4', component_l: 40, component_a: 120, component_b: -10)
          }                
          it 'save the record and its parts' do
            pc =  klass.new(valid_attributes)
            pc.add_part(valid_white_base, 40)
            pc.add_part(valid_pigment, 20)
            pc.add_part(valid_tint, 20)
            another_color2.save
            pc.add_part(another_color2, 20)
            expect(pc.parts).to match_array([valid_pigment, valid_tint, valid_white_base, another_color2])
            expect(pc.save).to be_truthy
            expect(WhiteBase.where(valid_white_base.attributes)).to  exist
            expect(Pigment.where(valid_pigment.attributes)).to  exist
            expect(Tint.where(valid_tint.attributes)).to  exist
            expect(PhysicalColor.where(another_color2.attributes)).to  exist
            expect(PcWhiteBasePart.where(white_base: valid_white_base, percentage: 40)).to exist            
            expect(PcPigmentPart.where(pigment: valid_pigment, percentage: 20)).to exist            
            expect(PcTintPart.where(tint: valid_tint, percentage: 20)).to exist            
            expect(PcPart.where(another_color: another_color2, percentage: 20)).to exist            
          end
        end
      end      
      context 'invalid due to another_color is not already stored in db' do
        let(:another_color3){
          PhysicalColor.new(name: 'Gray Sky76', component_l: 90, component_a: 22, component_b: 60)
        }         
        it 'does NOT save the color' do 
            pc =  klass.new(valid_attributes)
            pc.add_part(valid_white_base, 70)
            pc.add_part(another_color3, 30)          
            expect(pc.save).to be_falsy
            expect(PcWhiteBasePart.where(white_base: valid_white_base, percentage: 70)).not_to exist            
            expect(PcPart.where(another_color: another_color3, percentage: 30)).not_to exist            
        end
      end      
    end
  end
end


