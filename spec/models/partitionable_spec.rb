# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'rails_helper'

describe Partitionable do
  context 'when a class extends the module' do
    klass = PhysicalColor
    it 'is a Partitionable' do
      expect(klass).to be_a(Partitionable)
    end
    it 'response to interface partitionable'do
      expect(klass).to respond_to(:define_parts)
      expect(klass).to respond_to(:validations_for_parts)
    end
    context 'an instance of the class' do
      instance_obj = klass.new
      it 'response to generated interface' do 
        instance_obj.part_managers  #this is necessary to create the instance variable part_managers
        expect(instance_obj.instance_variable_defined?('@part_managers')).to be_truthy
        expect(instance_obj).to respond_to(:is_part_duck?)
        expect(instance_obj).to respond_to(:add_part!)
        expect(instance_obj).to respond_to(:add_part)
        expect(instance_obj).to respond_to(:parts)
        expect(instance_obj).to respond_to(:recipe)
        expect(instance_obj.recipe).to respond_to(:to_string)
      end
    end
  end
  
  
  
  describe 'PartAssociationManager' do
    klass = PhysicalColor
    list = [:white_base_parts, :pigment_parts]
    describe '.build_managers' do
      context 'when given a klass which extends partitionable and a list of associations' do
        it 'returns an array of managers ' do
          managers = Partitionable::PartAssociationManager.build_managers(klass, list)
          expect(managers).to be_a(Array)
          managers.each do |manager|
            expect(manager).to be_a(Partitionable::PartAssociationManager)
          end
        end
      end
    end
  end
  describe 'instance_methods' do 
    describe '#add_part' do
      pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
      pigment =  Pigment.new(name: 'Pigment 1')
      base =  WhiteBase.new(name: 'White Base 1')
      another_object =  "THIS IS NOT A VALID PART"      
      context 'when de part IS NOT a valid part' do 
        it 'DOES NOT add the part to object' do
          expect(pc.add_part(another_object)).to be_falsy
          expect(pc.parts).not_to include(another_object)
        end
      end
      context 'when de part is a valid part' do 
        it 'adds the part to object' do
          expect(pc.add_part(pigment)).to be_truthy
          expect(pc.parts).to include(pigment)
        end
      end
      context 'when the total percentage is in range (up to 100)' do
        it 'adds the percentage of part' do 
          expect(pc.add_part(pigment, 30)).to be_truthy
          expect(pc.add_part(pigment)).to be_truthy
          expect(pc.add_part(pigment, 0)).to be_truthy
          expect(pc.add_part(pigment, 20)).to be_truthy
          expect(pc.add_part(base, 30)).to be_truthy
          expect(pc.parts).to include(pigment)
          expect(pc.parts).to include(base)
        end
      end
      context 'when the total percentage is overcome (up to 100)' do
        it 'does not add the part' do 
          expect(pc.add_part(base, 30)).to be_falsy
        end
        it 'raise an error if used the bang method' do
          expect{pc.add_part!(base, 40)}.to raise_error(Partitionable::PartitionableError)
        end
      end
    end
    
    describe '#parts' do 
      context 'when HAS NOT parts' do
        pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
        it 'returns an empty array' do
          expect(pc.parts).to be_empty
        end
      end   
      context 'when HAS parts' do
        pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
        pigment =  Pigment.new(name: 'Pigment 1')
        white =  WhiteBase.new(name: 'White Base' )
        pc.add_part(pigment)
        pc.add_part(white)
        it 'returns all the parts in an array' do
          parts  = pc.parts
          expect(parts).not_to be_empty
          expect(parts).to match_array [white, pigment]  #it does not care about order
        end
      end
    end
    describe '#recipe' do 
      context 'when HAS NOT parts' do
        pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
        recipe = pc.recipe
        it 'returns an empty recipe' do
          expect(recipe).to be_empty
        end
        context '#to_string' do 
          it 'return an empty string' do 
            expect(recipe.to_string).to be_empty
          end
        end
      end
      context 'when HAS parts' do
        pc =  PhysicalColor.new(component_l: 50, component_a: 40, component_b: 30 )
        pigment =  Pigment.new(name: 'Pigment 1')
        white =  WhiteBase.new(name: 'White Base' )
        pc.add_part(pigment, 25)
        pc.add_part(white, 30)
        recipe  = pc.recipe
        it 'returns the recipe containing every part and percentage' do
          expect(recipe[:pigments].first).to match_array [pigment, 25]
          expect(recipe[:white_bases].first).to match_array [white, 30]
        end
        context '#to_string' do 
          it 'returns a string with textual recipe' do
              expect(recipe.to_string).to match(/25/)
              expect(recipe.to_string).to match(/#{pigment.name}/)
              expect(recipe.to_string).to match(/30/)
              expect(recipe.to_string).to match(/#{white.name}/)
          end
        end
      end      
    end  
  end  
  
  
end

