require_relative '../../docker/files/step'

module Frameworks
  module Steps
    class Finish < Docker::Files::Step

      def instructions
        %Q(
        RUN #{context.release_path}/finish.sh
        )
      end

    end
  end
end
