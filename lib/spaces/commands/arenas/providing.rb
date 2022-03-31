require_relative 'saving'

module Arenas
  module Commands
    class Providing < Saving

      def model
        @model ||= current_model.provide_for(role_identifier, provider_identifier)
      end

      def role_identifier
        input[:role_identifier]&.to_s || (raise ::Spaces::Errors::MissingInput, {input: input})
      end

      def provider_identifier
        input[:provider_identifier]&.to_s || (raise ::Spaces::Errors::MissingInput, {input: input})
      end

    end
  end
end
