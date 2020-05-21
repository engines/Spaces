require_relative '../../docker/files/step'

module Frameworks
  module Steps
    class Final < Docker::Files::Step

      def instructions
        %Q(
        RUN /build/scripts/framework/#{context.identifier}/finalisation.sh
        )
      end

    end
  end
end
