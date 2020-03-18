module Installations
  module Collaboration

    def class_for(concern, symbol)
      Module.const_get(namespaced_name(namespace_for(concern), symbol))

      rescue NameError
        Module.const_get(namespaced_name(generalised_namespace_for(concern), symbol))
    end

    def namespace_for(concern)
      [self.class.name.split('::')[0 .. -2], concern].flatten.join('::')
    end

    def generalised_namespace_for(concern)
      [self.class.name.split('::').first, concern].join('::')
    end

  end
end
