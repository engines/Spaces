module Publishing
  module Commands
    class Importing < ::Spaces::Commands::Saving

      delegate(locations: :universe)

      def model
        @model ||=
          super.well_formed? ? super : locations.by(identifier)
      end

      def force
        input[:force] || false
      end

      def space_identifier
        super || :publications
      end

      def model_class
        locations.default_model_class
      end

      def execute(&block)
        locations.save(model)
        space.import(model, force: force, &block)
      end

      protected

      def force
        input[:force]
      end

      def commit(&block)
        input[:threaded] ? outputting(&block) : execute(&block)
      end

      def outputting(&block)
        Spaces::Outputting::Import
        .new(command: self, identifier: input[:identifier])
        .write(&block)
      end

    end
  end
end
