require_relative 'requires'

module Framework
  class ApachePHP
    class FromImage < Docker::File::Step

      def content
        "FROM engines/php:current"
      end

    end
  end
end
