module Publishing
  module Commands
    class Exporting < ::Spaces::Commands::Running

      def space_identifier
        super || :publications
      end

      protected

      def commit
        space.export(**input)
      end

    end
  end
end
