module Providers
  module Interfacing
    
    def interface_for(emission)
      interface_class_for(emission.qualifier).new(emission)
    end

    def interface_class_for(qualifier)
      class_for(nesting_elements, [qualifier, :interface].compact.join('_'))
    end

  end
end
