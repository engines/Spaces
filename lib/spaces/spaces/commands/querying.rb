require_relative 'running'

module Spaces
  module Commands
    class Querying < Running

      def method
        input[:method]
      end

      def models
        @models ||= space.send(*method).tap { |m| struct.result = m }
      end

      alias_method :assemble, :models

    end
  end
end
