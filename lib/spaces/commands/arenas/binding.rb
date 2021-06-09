require_relative 'saving'

module Arenas
  module Commands
    class Binding < Saving

      def model
        @model ||= current_model.bind_with(blueprint_identifier)
      end

      def blueprint_identifier
        input[:blueprint_identifier]&.to_s || (raise ::Spaces::Errors::MissingInput, {input: input})
      end

    end
  end
end
