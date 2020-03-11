module Docker
  module Files
    module Collaboration

      def step_precedence
        self.class.step_precedence
      end

      def layers_for(group)
        step_precedence[group]&.map do |s|
          step_class(s).new(self).product
        end
      end

      def step_class(symbol)
        Module.const_get(namespaced_name(step_namespace, symbol))
      end

      def step_namespace
        [self.class.name.split('::')[0 .. -2], 'Steps'].flatten.join('::')
      end

    end
  end
end
