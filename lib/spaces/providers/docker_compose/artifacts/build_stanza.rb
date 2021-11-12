module Artifacts
  module DockerCompose
    class BuildStanza < ::Artifacts::Stanza

      def snippets
        {
          context: packs.path_for(resolution).to_s,
          args: [
            :buildno,
            :gitcommithash
          ],
          labels: {
            author: :james,
            other_label: :gidday
          },
          sysctls: {
            'net.core.somaxconn': 1024
          }
        }
      end

    end
  end
end
