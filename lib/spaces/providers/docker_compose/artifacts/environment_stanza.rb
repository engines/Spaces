module Artifacts
  module DockerCompose
    class EnvironmentStanza < ::Artifacts::Stanza

      def snippets =
        resolution.configuration.to_h.transform_values(&:to_s)

    end
  end
end
