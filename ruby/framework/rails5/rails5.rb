require_relative '../framework'

module Framework
    class Rails5 < Framework

      class << self
        def identifier
          'rails5'
        end

        def step_precedence
          @@rails5_step_precedence ||= [:initial, :variables, :bundle, :rake_tasks]
        end
      end

      def layers
        step_precedence.each { |s| require_relative "steps/#{s}" }
        super
      end

      def step_module_name
        "Framework::Rails5"
      end

    end
end
