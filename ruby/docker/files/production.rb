require_relative '../../spaces/constantizing'

module Docker
  module Files
    module Production
      include Spaces::Constantizing

      def step_precedence
        klass.step_precedence
      end

      def layers_for(group)
        step_precedence[group]&.map do |s|
          class_for('Steps', s).new(self).product
        end
      end

    end
  end
end
