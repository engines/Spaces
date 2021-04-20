require_relative 'running'

module Spaces
  module Commands
    class Modelling < Running

      def current_model
        @model ||= if space.exist?(identifier)
          space.by(identifier)
        end
      end

      def fresh_model
        @model ||= model_class.new(identifier: identifier, struct: model_struct)
      end

      def identifier
        input[:identifier]
      end

      def model_class
        space.default_model_class
      end

      def model_struct
        input[:model]&.to_struct
      end

    end
  end
end
