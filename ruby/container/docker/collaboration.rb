module Container
  module Docker
    module Collaboration

      def step_precedence
        self.class.step_precedence
      end

      def layers_for(group)
        step_precedence[group]&.map do |s|
          step_class(s).new(self).content
        end
      end

      def step_class(symbol)
        Module.const_get(step_class_name(step_module_name, symbol))
      end

      def step_class_name(module_name, symbol)
        "#{module_name}::#{symbol.to_s.split('_').map { |i| i.capitalize }.join}"
      end

      def step_module_name
        self.class.name
      end
    end
  end
end
