require 'rails_helper'

describe ColorModule::Converters::ColorModelConverter do
  a_color = {
    rgb: [80, 50, 230],
    cmyk: [0.6521, 0.7826, 0.0, 0.0980], 
    xyz: [0.1962, 0.0438, 0.7597],
    lab: [24.8899, 117.5363, -124.9287]
  }
    

  proc =  Proc.new do |class_name, instance_body|
    it class_name do
      instance_eval(instance_body)
    end
  end  
  
  describe 'BasicColorModelConverter module' do
    methods =[:rgb_to_cmyk, :cmyk_to_rgb, :rgb_to_xyz, :xyz_to_rgb, :xyz_to_lab, :lab_to_xyz]
    methods.each do  |m|
      class_eval do 
        describe "##{m}" do
          parts =  m.to_s.split(/_to_/)
          it_name = "converts #{parts.first} to #{parts.last}"
          string = "model =  ColorModule::Spaces::#{parts.first.upcase}Model.new \n" +
            "model.assign_components(*#{a_color[parts.first.to_sym]}) \n" +
            "new_model = ColorModule::Spaces::#{parts.last.upcase}Model.new \n" +
            "new_model.assign_components(*#{a_color[parts.last.to_sym]}) \n" +
            "converter = ColorModule::Converters::ColorModelConverter.new(model) \n" +
            "expect(converter.#{m}(model)).to eql(new_model) \n"
          proc.call(it_name, string)
        end
      end
    end
  end
  
  describe '#perform_conversion' do
    
    spaces= [:rgb, :cmyk, :xyz, :lab]
    methods = spaces.flat_map{|s| spaces.map{|r| "#{s}_to_#{r}" } }
    methods.each do |m|
      class_eval do 
        describe "#{m}" do        
          parts =  m.split(/_to_/)
          it_name = "converts from #{parts.first} to #{parts.last}"
          string = "model =  ColorModule::Spaces::#{parts.first.upcase}Model.new \n" +
            "model.assign_components(*#{a_color[parts.first.to_sym]}) \n" +
            "new_model = ColorModule::Spaces::#{parts.last.upcase}Model.new \n" +
            "new_model.assign_components(*#{a_color[parts.last.to_sym]}) \n" +
            "expect(model.convert_to(:#{parts.last})).to eql(new_model)"
          proc.call(it_name, string)
        end
      end
    end
  end
end

