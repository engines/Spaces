module Artifacts
  module DockerCompose
    class DependsOnStanza < ::Artifacts::Stanza

      def snippets
        if (rcd = resolution.connections_down).any?
          rcd.map { |c| c.blueprint_identifier.hyphenated }
        end
      end

    end
  end
end
