require_relative 'requires'

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
