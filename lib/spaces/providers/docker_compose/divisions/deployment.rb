module Divisions
  module DockerCompose
    class Deployment < ::Divisions::Deployment

      class << self
        def default_struct
          OpenStruct.new(
            restart_policy: {
              condition: 'on-failure',
              delay: '5s',
              max_attempts: 3,
              window: '120s'
            },
            resources: {
              limits: {
                cpus: '1',
                memory: '1G'
              }
            }
          )
        end
      end

    end
  end
end
