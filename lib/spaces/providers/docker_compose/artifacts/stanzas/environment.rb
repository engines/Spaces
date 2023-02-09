module Artifacts
  module DockerCompose
    module Stanzas
      class Environment < Stanza

        def snippets =
          resolution.configuration.to_h.transform_values(&:to_s)

      end
    end
  end
end
