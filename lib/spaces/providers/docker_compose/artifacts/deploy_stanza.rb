module Artifacts
  module DockerCompose
    class DeployStanza < ::Artifacts::Stanza

      def snippets
        {
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
        }
      end

    end
  end
end
