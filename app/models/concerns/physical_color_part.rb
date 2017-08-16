#expose the interface the parts of a PhysicalColor should implement
module PhysicalColorPart
    def object_part
      raise NotImplementedError
    end
    
    def percentage
      @percentage
    end
    
    def object_part=(arg)
      raise NotImplementedError
    end
    
    def description
      name
    end
end
