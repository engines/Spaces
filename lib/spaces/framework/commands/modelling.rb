require_relative 'command'

module Spaces
  module Commands
    class Modelling < Command

      def current_model
        @model ||= space.by(identifier)
      end

      def fresh_model
        @model ||= model_class.new(identifiable: identifier, struct: model_struct)
      end

      def identifier =
        (input[:identifier] || input.dig(:model, :identifier))&.to_s

      def model_class = space.default_model_class

      def model_struct = input[:model]&.clean&.to_struct

    end
  end
end
