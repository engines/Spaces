module Publishing
  module Commands
    class Importing < ::Spaces::Commands::Saving
      include ::Streaming::Streaming

      delegate(locations: :universe)

      def model
        @model ||=
        super.well_formed? ? super : locations.by(identifier)
      end

      def model_class = locations.default_model_class
        
      def stream_elements = [space.identifier, model.identifier, qualifier, input_for(:timestamp)]

      protected

      def commit
        with_streaming do
          space.import(model, force: force, stream: stream)
        end
      end

    end
  end
end
