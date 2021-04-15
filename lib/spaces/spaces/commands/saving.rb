require_relative 'reading'

module Spaces
  module Commands
    class Saving < ::Spaces::Commands::Reading

      def assemble
        @model ||= model_class.new(identifier: identifier, struct: model_struct)
      end

      def commit
        struct.result = space.save(model)
      end

      def model_struct
        input[:model]&.to_struct
      end

    end
  end
end
