module Publishing
  module Commands
    class Importing < ::Spaces::Commands::Saving

      delegate(locations: :universe)

      def model
        @model ||=
          super.well_formed? ? super : locations.by(identifier)
      end

      def model_class
        locations.default_model_class
      end

      protected

      def commit
        locations.save(model)
        space.import(model, force: force)
      end

    end
  end
end
