module Artifacts
  module DockerCompose
    class VolumesStanza < ::Artifacts::Stanza

      def snippets
        resolution.volumes.map do |v|
          {
            type: v.type,
            "#{v.source}": v.destination
          }
        end if resolution.has?(:volumes)
      end

    end
  end
end
