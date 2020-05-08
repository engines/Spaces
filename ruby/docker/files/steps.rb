require_relative '../../spaces/constantizing'

module Docker
  module Files
    module Steps
      include Spaces::Constantizing

      def layers_for(group)
        step_precedence[group]&.map do |s|
          begin
            class_for('Steps', s)
          rescue NameError
            general_steps[s]
          end.new(self).instructions
        end
      end

      def step_precedence; klass.step_precedence ;end

      def general_steps
        {
          runs: ::Docker::Files::Steps::Runs
        }
      end

    end
  end
end
