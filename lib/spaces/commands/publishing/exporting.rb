module Publishing
  module Commands
    class Exporting < ::Spaces::Commands::Command

      def space_identifier
        super || :publications
      end

      protected

      def commit(&block)
        space.export(**input, &block)
      end

    end
  end
end
