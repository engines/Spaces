module Artifacts
  module DockerCompose
    class ContainerStanza < ::Artifacts::Stanza

      relation_accessor :resolution

      def stanza_qualifiers
        [:build, :deploy, :environment, :ports, :logging, :volumes]
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
          domainname: universe.host,
          hostname: resolution.identifier.underscore
        }
      end

      def initialize(holder, resolution)
        super(holder)
        self.resolution = resolution
      end

    end
  end
end
