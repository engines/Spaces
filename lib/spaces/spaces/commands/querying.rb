require_relative 'running'

module Spaces
  module Commands
    class Querying < Running

      def method_signature
        [input[:method], input.except(:method, :space)]
      end

      def models
        @models ||= space.send(*method_signature)
      end

      alias_method :assembly, :models

    end
  end
end
