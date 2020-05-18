require_relative '../../spaces/constantizing'
require_relative 'steps/runs'
require_relative 'native_step'

module Docker
  module Files
    module Steps
      include Spaces::Constantizing

      def layers_for(group)
        steps_for(group)&.map(&:instructions)
      end

      def steps_for(group)
        step_precedence[group]&.map do |s|
          begin
            class_for('Steps', s)
          rescue NameError => e
            warn(e, group: group, step: s)
            general_steps[s]
          end.new(self)
        end
      end

      def step_precedence; klass.step_precedence ;end

      def general_steps
        {
          native: ::Docker::Files::NativeStep,
          runs: ::Docker::Files::Steps::Runs
        }
      end

    end
  end
end
