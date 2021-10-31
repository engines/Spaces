module Artifacts
  module DockerCompose
    class DeployStanza < ::Artifacts::Stanza

      def snippets
        {
          deploy: {
            restart_policy: {
              condition: 'on-failure',
              delay: '5s',
              max_attempts: 3,
              window: '120s'
            },
            ports: ports_snippets,
            resources: {
              limits: {
                cpus: '1',
                memory: '1G'
              }
            },
            environment: environment_snippets,
            logging: {
              driver: :syslog,
              options: {
                'syslog-address': "tcp://192.168.0.42:123"
              }
            },
            volumes: volumes_snippets,
            domainname: resolution.domain.identifier,
            hostname: resolution.blueprint_identifier
          }.compact
        }
      end

      def ports_snippets
        resolution.ports.map do |p|
          {
            target: p.external_port,
            published: p.start_port,
            protocol: p.protocol,
            mode: :host
          }
        end if resolution.has?(:ports)
      end

      def volumes_snippets
        resolution.volumes.map do |v|
          {"#{v.source}": v.destination}
        end if resolution.has?(:volumes)
      end

      def environment_snippets
        resolution.configuration.to_h
      end

    end
  end
end
