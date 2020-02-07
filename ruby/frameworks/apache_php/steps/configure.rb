require_relative 'requires'

module Frameworks
  class ApachePHP
    class Configure < Docker::File::Step

      def content
      %Q(
        USER 0
        RUN /scripts/configure_apache.sh
      )
      end

    end
  end
end
