require_relative 'requires'

module Frameworks
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
