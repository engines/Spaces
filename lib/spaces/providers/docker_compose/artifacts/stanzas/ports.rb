module Artifacts
  module DockerCompose
    module Stanzas
      class Ports < Stanza

        def snippets
          resolution.ports.map do |p|
            {
              target: p.container_port,
              published: p.host_port,
              protocol: p.protocol,
              mode: :host
            }
          end if resolution.has?(:ports)
        end

      end
    end
  end
end
