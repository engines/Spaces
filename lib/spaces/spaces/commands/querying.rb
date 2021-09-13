require_relative 'command'

module Spaces
  module Commands
    class Querying < Command

      def method_signature
        # debugger
        [method, arguments].compact
      end

      def method
        input[:method] || (raise ::Spaces::Errors::MissingInput, {input: input})
      end

      def arguments
        _arguments unless _arguments.empty?
      end

      def models
        # debugger
        @models ||= space.send(*method_signature)
      end

      alias_method :assembly, :models

      protected

      def _arguments
        # debugger
        input.slice(space.method(method).parameters.map(&:last))
      end

    end
  end
end
