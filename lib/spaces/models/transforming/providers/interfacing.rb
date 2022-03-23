module Providers
  module Interfacing

    def interface_for(emission)
      interface_class_for(emission).new(emission)
    end

    def interface_class_for(emission)
      class_for(nesting_elements, [emission.qualifier, :interface].compact.join('_'))
    end

  end
end
