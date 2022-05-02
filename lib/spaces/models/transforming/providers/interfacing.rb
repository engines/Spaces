module Providers
  module Interfacing

    def interface_for(emission, **args)
      interface_class_for(emission.qualifier).new(emission, **args)
    end

    def interface_class_for(qualifier)
      class_for(nesting_elements, [qualifier, :interface].compact.join('_'))
    end

    def interface_for_all_in(space_identifier)
      interface_class_for(space_identifier).new(nil)
    end

  end
end
