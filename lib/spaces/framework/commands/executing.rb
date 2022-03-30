require_relative 'reading'

module Spaces
  module Commands
    class Executing < Reading

      def instruction
        input[:execute]
      end

      protected

      def commit
        space.execute(instruction, model)
      rescue TypeError
        raise ::Spaces::Errors::MissingInput, {input: input}
      end

    end
  end
end
