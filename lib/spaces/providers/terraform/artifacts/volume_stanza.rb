module Artifacts
  module Terraform
    class VolumeStanza < ::Artifacts::Stanza

      def snippets
        %(
          resource "docker_volume" "#{volume_name}"  {
            name = "#{volume_name}"
            driver = "local"
          }
        ) if volumes
      end

      def volume_name
        volumes.all.map(&:volume_name).join
      end

    end
  end
end
