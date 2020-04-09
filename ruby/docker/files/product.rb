require_relative '../../spaces/constantizing'

module Docker
  module Files
    module Product
      include Spaces::Constantizing

      def layers_for(group)
        step_precedence[group]&.map do |s|
          class_for('Steps', s).new(self).product
        end
      end

      def step_precedence
        klass.step_precedence
      end

    end
  end
end
