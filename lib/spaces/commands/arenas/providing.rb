require_relative 'saving'

module Arenas
  module Commands
    class Providing < Saving

      def model
        @model ||= current_model.provide_for(**(input.without(:identifier, :space)))
      end

    end
  end
end
