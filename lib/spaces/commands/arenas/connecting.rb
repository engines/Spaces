require_relative 'saving'

module Arenas
  module Commands
    class Connecting < Saving

      def model
        @model ||= current_model.connect_with(other_identifier)
      end

      def other_identifier
        input_for(:other_identifier)
      end

    end
  end
end
