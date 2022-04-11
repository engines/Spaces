module Publishing
  module Commands
    class Identifying < ::Spaces::Commands::Reading

      delegate(locations: :universe)

      def assembly
        model.identifier
      end

      def model
        @model ||= model_class.new(model_struct)
      end

      def model_class
        locations.default_model_class
      end

    end
  end
end
