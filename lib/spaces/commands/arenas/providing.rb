require_relative 'saving'

module Arenas
  module Commands
    class Providing < Saving

      def model
        @model ||= current_model.provide_for(role_identifier, provider_identifier)
      end

      def role_identifier
        input_for(:role_identifier)
      end

      def provider_identifier
        input_for(:provider_identifier)
      end

      def resolution_identifier
        input_for(:provider_identifier, mandatory: false)
      end

    end
  end
end
