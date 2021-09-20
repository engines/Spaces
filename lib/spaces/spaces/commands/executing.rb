require_relative 'reading'

module Spaces
  module Commands
    class Executing < Reading

      def execution_instruction
        input[:execute]
      end

      protected

      def commit
        space.send(execution_instruction, model)
      end

    end
  end
end
