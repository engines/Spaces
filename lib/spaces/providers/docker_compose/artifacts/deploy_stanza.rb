module Artifacts
  module DockerCompose
    class DeployStanza < ::Artifacts::Stanza

      def snippets; resolution.deployment.to_h ;end

    end
  end
end
