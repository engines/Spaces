module Publishing
  module Commands
    class Exporting < ::Spaces::Commands::Command

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
