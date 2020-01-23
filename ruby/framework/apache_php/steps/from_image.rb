require_relative 'requires'

module Framework
  class ApachePHP
    class FromImage < Container::Docker::Step

      def content
        "FROM spaces/php:current"
      end

    end
  end
end
