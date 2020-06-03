module Spaces
  module Constantizing

    def class_for(concern, symbol)
      Module.const_get(namespaced_name(namespace_for(concern), symbol))
    end

    def namespace_for(concern)
      [self.class.name.split('::')[0 .. -2], concern].flatten.join('::')
    end

    def general_class_for(concern, symbol)
      Module.const_get(namespaced_name(general_namespace_for(concern), symbol))
    end

    def general_namespace_for(concern)
      [self.class.name.split('::').first, concern].join('::')
    end

  end
end
