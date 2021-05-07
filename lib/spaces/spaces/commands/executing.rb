module Spaces
  module Commands
    class Executing < Spaces::Commands::Reading

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
