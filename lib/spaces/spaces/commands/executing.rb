require_relative 'reading'

module Spaces
  module Commands
    class Executing < Reading

      def execution_instruction
        input[:execute]
      end

      protected

      def commit(&block)
        space.send(execution_instruction, model, &block)
      end

    end
  end
end
