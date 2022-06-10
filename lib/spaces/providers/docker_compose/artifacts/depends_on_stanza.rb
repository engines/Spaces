module Artifacts
  module DockerCompose
    class DependsOnStanza < ::Artifacts::Stanza

      def snippets
        if (rcd = resolution.direct_connections).any?
          rcd.map { |c| c.application_identifier.underscore }
        end
      end

    end
  end
end
