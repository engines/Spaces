require_relative 'command'

module Spaces
  module Commands
    class Existing < ::Spaces::Commands::Command

      def identifier
        input[:identifier]&.to_s
      end

      protected

      def _run
        struct.result = space.exist?(identifier)
      end

    end
  end
end
