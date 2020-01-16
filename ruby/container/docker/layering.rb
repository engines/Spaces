module Container
  module Docker
    module Layering
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def precedence
          @@precedence ||= [:initial, :variables, :volumes, :adds, :steps, :final]
        end
      end

      def precedence
        self.class.precedence
      end

      def step_precedence
        @step_precedence ||= []
      end

      def steps
        step_precedence.map { |s| send(s) }
      end

    end
  end
end
