#expose the interface of partitionable objects
module Partitionable
  def define_parts(*arg)
    list =  arg.flatten
    class_eval do 
      define_method(:parts) do
        all_parts =  Array.new
        list.each do |part|
          all_parts << send(part).to_a
        end
        all_parts.flatten
      end
    end
  end
end
