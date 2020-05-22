require_relative '../../docker/files/step'

module Frameworks
  module Steps
    class Finish < Docker::Files::Step

      def instructions
        %Q(
        RUN /build/scripts/framework/#{context.identifier}/finish.sh
        )
      end

    end
  end
end
