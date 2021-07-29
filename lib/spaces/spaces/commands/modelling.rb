require_relative 'running'

module Spaces
  module Commands
    class Modelling < Running

      def current_model
        @model ||= space.by(identifier)
      end

      def fresh_model
        @model ||= model_class.new(identifiable: identifier, struct: model_struct)
      end

      def identifier
        input[:identifier]&.to_s
      end

      def model_class
        space.default_model_class
      end

      def model_struct
        input[:model]&.clean&.to_struct
      end

    end
  end
end
