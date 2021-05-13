require_relative 'running'

module Spaces
  module Commands
    class Querying < Running

      def method_signature
        [method, arguments].compact
      end

      def method
        input[:method] || (raise ::Spaces::Errors::MissingInput, {input: input})
      end

      def arguments
        a unless (a = input.without(:method, :space)).empty?
      end

      def models
        @models ||= space.send(*method_signature)
      end

      alias_method :assembly, :models

    end
  end
end
