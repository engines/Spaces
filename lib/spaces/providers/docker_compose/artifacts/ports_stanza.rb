module Artifacts
  module DockerCompose
    class PortsStanza < ::Artifacts::Stanza

      def snippets
        resolution.ports.map do |p|
          {
            target: p.start_port,
            published: p.external_port,
            protocol: p.protocol,
            mode: :host
          }
        end if resolution.has?(:ports)
      end

    end
  end
end
