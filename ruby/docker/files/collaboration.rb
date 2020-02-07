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
    end

  end
end
