require_relative 'requires'

module Docker
  module Files
    module Steps
      class Adds < Docker::Files::Step

        def product
          %Q(
          ADD scripts /scripts
          ADD home home
          ADD engines home/engines
          ADD home/start.sh /home/engines/scripts/startup/start.sh
          )
        end

      end
    end
  end
end
