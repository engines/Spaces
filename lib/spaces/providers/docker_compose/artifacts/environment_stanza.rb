module Artifacts
  module DockerCompose
    class EnvironmentStanza < ::Artifacts::Stanza

      def snippets
        resolution.configuration.to_h
      end

    end
  end
end
