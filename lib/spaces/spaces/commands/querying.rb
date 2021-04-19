require_relative 'running'

module Spaces
  module Commands
    class Querying < Running

      def method
        input[:method]
      end

      def models
        @models ||= space.send(*method)
      end

      alias_method :assembly, :models

    end
  end
end
