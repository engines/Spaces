module Publishing
  module Commands
    class Importing < ::Spaces::Commands::Saving

      def model
        @model ||= universe.locations.by(identifier)
      end

      def force
        input[:force] || false
      end

      def space_identifier
        super || :publications
      end

      protected

      def commit(&block)
        space.import(model, force: force, &block)
      end

    end
  end
end
