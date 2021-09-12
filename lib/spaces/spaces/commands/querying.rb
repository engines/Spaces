require_relative 'command'

module Spaces
  module Commands
    class Querying < Command

      def methud_signature
        [methud, arguments].compact
      end

      def methud
        input[:method] || (raise ::Spaces::Errors::MissingInput, {input: input})
      end

      def arguments
        _arguments unless _arguments.empty?
      end

      def models
        @models ||= space.send(*methud_signature)
      end

      alias_method :assembly, :models

      protected

      def _arguments
        input.slice(space.method(methud).parameters.map(&:last))
      end

    end
  end
end
