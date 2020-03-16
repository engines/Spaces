require_relative '../../installations/collaboration'

module Docker
  module Files
    module Collaboration
      include Installations::Collaboration

      def step_precedence
        self.class.step_precedence
      end

      def layers_for(group)
        step_precedence[group]&.map do |s|
          class_for('Steps', s).new(self).product
        end
      end

    end
  end
end
