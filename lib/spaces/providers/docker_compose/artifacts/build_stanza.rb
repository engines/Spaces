module Artifacts
  module DockerCompose
    class BuildStanza < ::Artifacts::Stanza

      def snippets
        {
          build: {
            context: "./#{resolution.identifier}_docker_dir",
            args: [
              :buildno,
              :gitcommithash
            ],
            labels: {
              author: :james,
              other_label: :gidday
            },
            target: resolution.identifier,
            depends_on: connections_down.map(&:identifier)
          }
        }
      end

    end
  end
end
