require_relative 'reading'

module Spaces
  module Commands
    class Executing < Reading

      def instruction
        input_for(:execute)
      end

      protected

      def commit
        space.execute(instruction, model)
      end

    end
  end
end
