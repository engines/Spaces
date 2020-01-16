module Container
  module Docker
    module Collaboration

      def step_precedence
        self.class.step_precedence
      end

      def layers
        step_classes.map { |s| s.new(self).content }
      end

      def step_classes
        @steps ||= step_precedence.map do |s|
          Module.const_get("#{step_module_name}::#{s.to_s.split('_').map { |i| i.capitalize }.join}")
        end
      end
    end
  end
end
