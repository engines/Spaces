require_relative 'requires'

module Frameworks
  class ApachePHP
    class FromImage < Docker::File::Step

      def content
        "FROM engines/php:current"
      end

    end
  end
end
