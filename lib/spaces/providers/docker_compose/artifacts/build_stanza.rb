module Artifacts
  module DockerCompose
    class BuildStanza < ::Artifacts::Stanza

      def snippets
        {
          context: "./#{resolution.blueprint_identifier.hyphenated}",
          args: [
            :buildno,
            :gitcommithash
          ],
          labels: {
            author: :james,
            other_label: :gidday
          }
        }
      end

    end
  end
end
