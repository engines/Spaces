module Publishing
  module Commands
    class Exporting < ::Spaces::Commands::Command

      def space_identifier
        super || :publications
      end

      def execute(&block)
        space.export(**input, &block)
      end

      protected

      def commit(&block)
        input[:threaded] ? outputting(&block) : execute(&block)
      end

      def outputting(&block)
        Spaces::Outputting::Export
        .new(command: self, identifier: input[:identifier])
        .write(&block)
      end

    end
  end
end
