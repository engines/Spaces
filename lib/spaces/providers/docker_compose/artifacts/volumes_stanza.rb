module Artifacts
  module DockerCompose
    class VolumesStanza < ::Artifacts::Stanza

      delegate([:identifier, :volumes, :full_service_path, :service_path] => :resolution)

      def snippets
        [resolution_snippets, default_snippets].flatten.compact
      end

      def resolution_snippets
        volumes.map do |v|
          "#{v.source}:#{v.destination}" if v.mount?
        end if resolution.has?(:volumes)
      end

      def default_snippets
        [
          "#{volume_path}/log/#{identifier.as_path}:/var/logs",
          "#{full_service_path}:#{service_path}"
        ]
      end

    end
  end
end
