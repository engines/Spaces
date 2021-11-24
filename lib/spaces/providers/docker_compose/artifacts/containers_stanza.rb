module Artifacts
  module DockerCompose
    class ContainersStanza < ::Artifacts::Stanza

      def snippets
        {
          version: "3.3",
          services: container_snippets
        }
      end

      def container_snippets
        bound_resolutions_deep.reduce({}) do |m, r| # NOW WHAT?
          m.tap do
            m[r.blueprint_identifier.hyphenated] = container_stanza_class.new(self, r).snippets
          end
        end
      end

      def container_stanza_class; ContainerStanza; end

    end
  end
end
