require_relative 'running'

module Spaces
  module Commands
    class Querying < Running

      def method_signature
        [method, input.without(:method, :space)]
      end

      def method
        input[:method] || (raise ::Spaces::Errors::MissingInput, {input: input})
      end

      def models
        @models ||= space.send(*method_signature)
      end

      alias_method :assembly, :models

    end
  end
end
