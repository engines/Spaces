module Artifacts
  module DockerCompose
    class VolumeStanza < ::Artifacts::Stanza

      def snippets
        %(
        ) if volumes
      end

      # def volume_name
      #   volumes.all.map(&:volume_name).join
      # end

    end
  end
end
