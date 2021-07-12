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

      def commit
        space.import(model, force: force)
      end

    end
  end
end
