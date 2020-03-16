module Images
  module Collaboration

    def script_lot
      self.class.script_lot
    end

    def scripts
      script_lot.map { |s| script_class(s).new(self) }
    end

    def script_class(symbol)
      Module.const_get(namespaced_name(script_namespace, symbol))
    end

    def script_namespace
      [self.class.name.split('::')[0 .. -2], 'Scripts'].flatten.join('::')
    end

    def build_script_path
      'build/scripts'
    end

  end
end
