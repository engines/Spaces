require_relative 'requires'

module Frameworks
  class ApachePHP
    class FromImage < Docker::Files::Step

      def content
        "FROM engines/php:current"
      end

    end
  end
end
