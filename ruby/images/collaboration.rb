require_relative '../products/product'

module Images
  module Collaboration

    def script_precedence
      self.class.script_precedence
    end

    def scripts
      script_precedence.map { |s| script_class(s).new(self) }
    end

    def script_class(symbol)
      Module.const_get(namespaced_name(script_namespace, symbol))
    end

    def script_namespace
      [self.class.name.split('::')[0 .. -2], 'Scripts'].flatten.join('::')
    end

  end
end
