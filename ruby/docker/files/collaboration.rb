module Docker
  module Files
    module Collaboration

      def step_precedence
        self.class.step_precedence
      end

      def layers_for(group)
        step_precedence[group]&.map do |s|
          scoped_class(s).new(self).content
        end
      end

      def scope_module_name
        [self.class.name.split('::')[0 .. -2], 'Steps'].flatten.join('::')
      end

    end
  end
end
