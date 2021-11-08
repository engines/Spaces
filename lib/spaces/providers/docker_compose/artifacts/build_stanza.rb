module Artifacts
  module DockerCompose
    class BuildStanza < ::Artifacts::Stanza

      def snippets
        {
          context: "./#{resolution.identifier.as_path}",
          args: [
            :buildno,
            :gitcommithash
          ],
          labels: {
            author: :james,
            other_label: :gidday
          },
          target: resolution.identifier.underscore,
          depends_on: connections_down.map(&:identifier).map(&:underscore)
        }
      end

    end
  end
end
