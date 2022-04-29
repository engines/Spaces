require_relative 'saving'

module Arenas
  module Commands
    class Binding < Saving

      def model
        @model ||= current_model.bind_with(blueprint_identifier)
      end

      def blueprint_identifier
        input_for(:blueprint_identifier).to_s
      end

    end
  end
end
