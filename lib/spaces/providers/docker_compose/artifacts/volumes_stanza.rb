module Artifacts
  module DockerCompose
    class VolumesStanza < ::Artifacts::Stanza

      def snippets
        resolution.volumes.map do |v|
          "#{v.source}:#{v.destination}" if v.bind?
        end if resolution.has?(:volumes)
      end

    end
  end
end
