module Artifacts
  module DockerCompose
    class ContainersStanza < ::Artifacts::Stanza

      def snippets
        {
          version: "3.9",
          services: container_snippets
        }
      end

      def container_snippets
        all_resolutions.reduce({}) do |m, r|
          m.tap do
            m[r.identifier] =container_stanza_class.new(self, r).snippets
          end
        end
      end

      def container_stanza_class; ContainerStanza; end

    end
  end
end
