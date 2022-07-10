require_relative 'command'

module Spaces
  module Commands
    class Querying < Command

      # TODO: Remove :method_signature and :arguments methods, if not used.

      def method_signature = [query_method, arguments].compact

      def query_method = input_for(:method)

      def arguments = (_arguments unless _arguments.empty?)

      def models
        @models ||= space.send(query_method, **_arguments)
      end

      alias_method :assembly, :models

      protected

      def _arguments
        input.slice(*space.method(query_method).parameters.map(&:last))
      end

    end
  end
end
