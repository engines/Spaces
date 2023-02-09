module Artifacts
  module DockerCompose
    module Stanzas
      class Build < Stanza

        def snippets =
          {
            context: packs.path_for(resolution).to_s,
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
