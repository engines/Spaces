module Artifacts
  module DockerCompose
    class ServicesStanza < ::Artifacts::Stanza

      def snippets
        {
          version: "3.3",
          services: service_snippets
        }
      end

      def service_snippets
        directly_bound_resolutions.reduce({}) do |m, r|
          m.tap do
            m[r.blueprint_identifier.hyphenated] = service_stanza_class.new(self, r).snippets
          end
        end
      end

      def service_stanza_class; ServiceStanza; end

    end
  end
end
