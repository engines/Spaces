require_relative 'command'

module Spaces
  module Commands
    class Existing < Command

      def identifier = input_for(:identifier, mandatory: false)

      protected

      def _run
        struct.result = space.exist?(identifier)
      end

    end
  end
end
