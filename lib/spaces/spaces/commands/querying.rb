require_relative 'command'

module Spaces
  module Commands
    class Querying < Command

      def method_signature
        [method, arguments].compact
      end

      def method
        input[:method] || (raise ::Spaces::Errors::MissingInput, {input: input})
      end

      def arguments
        unless (a = input.without(:method, :space)).empty?
          a
        end
      end

      def models
        @models ||= space.send(*method_signature)
      end

      alias_method :assembly, :models

    end
  end
end
