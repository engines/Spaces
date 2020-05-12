require_relative '../../docker/files/step'

module Starters
  module Steps
    class Adds < Docker::Files::Step

      def instructions
        %Q(
        ADD scripts /scripts
        ADD home home
        ADD spaces home/engines
        ADD home/start.sh /home/engines/scripts/startup/start.sh
        )
      end

    end
  end
end
