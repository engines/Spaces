module Artifacts
  module DockerCompose
    class ServiceStanza < ::Artifacts::Stanza

      relation_accessor :resolution

      def stanza_qualifiers
        [:build, :depends_on, :deploy, :sysctls, :environment, :ports, :logging, :volumes]
      end

      def snippets
        stanza_qualifiers.reduce(domain_and_hostname_snippets) do |m, q|
          m.tap do
            m[q] = stanza_class_for(q).new(self).snippets
          end
        end.compact
      end

      def domain_and_hostname_snippets
        {
          domainname: "#{arena.identifier.as_subdomain}.#{universe.host}",
          hostname: resolution.blueprint_identifier.as_subdomain
        }
      end

      def initialize(holder, resolution)
        super(holder)
        self.resolution = resolution
      end

    end
  end
end
