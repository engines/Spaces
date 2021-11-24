require_relative 'saving'

module Arenas
  module Commands
    class Connecting < Saving

      def model
        @model ||= current_model.connect_with(other_identifier)
      end

      def other_identifier
        input[:other_identifier]&.to_s || (raise ::Spaces::Errors::MissingInput, {input: input})
      end

    end
  end
end
