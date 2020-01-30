require_relative '../../spaces/product'

module Docker
  class File < ::Spaces::Product
    module Collaboration

      def step_precedence
        self.class.step_precedence
      end

      def script_precedence
        self.class.script_precedence
      end

      def scripts
        script_precedence.map { |s| scoped_class(s).new(self) }
      end

      def layers_for(group)
        step_precedence[group]&.map do |s|
          scoped_class(s).new(self).content
        end
      end

      def scoped_class(symbol)
        Module.const_get(scoped_class_name(scope_module_name, symbol))
      end

      def scoped_class_name(module_name, symbol)
        "#{module_name}::#{symbol.to_s.split('_').map { |i| i.capitalize }.join}"
      end

      def scope_module_name
        self.class.name
      end
    end
  end
end
