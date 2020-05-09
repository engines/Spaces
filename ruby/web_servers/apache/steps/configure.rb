require_relative '../../../docker/files/step'

module WebServers
  module Apache
    module Steps
      class Configure < Docker::Files::Step

        def instructions
        %Q(
          USER 0
          RUN /#{context.installation_path}/configure.sh
        )
        end

      end
    end
  end
end
