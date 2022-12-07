module Artifacts
  module DockerCompose
    module Stanzas
      class Deploy < Stanza

        def snippets = resolution.deployment.to_h

      end
    end
  end
end
