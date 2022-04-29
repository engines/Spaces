require_relative 'command'

module Spaces
  module Commands
    class Querying < Command

      def method_signature
        [query_method, arguments].compact
      end

      def query_method
        input_for(:method)
      end

      def arguments
        _arguments unless _arguments.empty?
      end

      def models
        @models ||= space.send(*method_signature)
      end

      alias_method :assembly, :models

      protected

      def _arguments
        input.slice(*space.method(query_method).parameters.map(&:last))
      end

    end
  end
end
