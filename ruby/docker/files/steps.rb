require_relative '../../spaces/constantizing'
require_relative 'steps/run'
require_relative 'native_step'

module Docker
  module Files
    module Steps
      include Spaces::Constantizing

      def layers_for(group)
        steps_for(group)&.map(&:instructions)
      end

      def steps_for(group)
        step_precedence[group]&.map { |s| step_for(s) }&.compact
      end

      def step_for(symbol)
        begin
          class_for(step_concern, symbol).new(self)
        rescue NameError
          general_step_for(symbol)
        end
      end

      def general_step_for(symbol)
        begin
          general_class_for(step_concern, symbol)
        rescue NameError => e
          general_steps[symbol] || warn(error: e, name: namespaced_name(namespace_for(step_concern), symbol))
        end&.new(self)
      end

      def general_steps
        {
          native: ::Docker::Files::NativeStep,
          run: ::Docker::Files::Steps::Run
        }
      end

      def step_precedence; klass.step_precedence ;end
      def step_concern; 'Steps' ;end

    end
  end
end
