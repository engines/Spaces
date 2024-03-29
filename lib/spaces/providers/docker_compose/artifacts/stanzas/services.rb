module Artifacts
  module DockerCompose
    module Stanzas
      class Services < Stanza

        def snippets =
          {
            version: "3.3",
            services: service_snippets
          }

        def service_snippets
          directly_bound_resolutions.reduce({}) do |m, r|
            m.tap do
              m[r.application_identifier.hyphenated] = service_stanza_class.new(self, r).snippets
            end
          end
        end

        def build_only_snippets
          golden_packs.reduce({}) do |m, p|
            m.tap do
              m[p.application_identifier.hyphenated] = service_stanza_class.new(self, p).build_only_snippets
            end
          end
        end

        def service_stanza_class = Service

      end
    end
  end
end
