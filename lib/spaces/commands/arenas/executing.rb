module Arenas
  module Commands
    class Executing < ::Spaces::Commands::Executing

      def space_identifier
        super || :arenas
      end

      def execute(&block)
        space.send(execution_instruction, model, &block)
      end

      protected

      def commit(&block)
        input[:threaded] ? filing(&block) : execute(&block)
      end

      def filing(&block)
        Spaces::Outputting::Execution
        .new(command: self, identifier: input[:identifier])
        .write(&block)
      end

    end
  end
end
