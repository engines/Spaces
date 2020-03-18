require_relative '../../../docker/files/collaboration'

module WebServers
  module Apache
    module Steps
      class Configure < Docker::Files::Step

        def product
        %Q(
          USER 0
          RUN /scripts/configure_apache.sh
        )
        end

      end
    end
  end
end
