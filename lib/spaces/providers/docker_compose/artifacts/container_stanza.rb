module Artifacts
  module DockerCompose
    class ContainerStanza < ::Artifacts::Stanza

      relation_accessor :resolution

      def stanza_qualifiers
        [:build, :deploy]
      end

      def snippets
        stanza_qualifiers.reduce({}) do |m, q|
          m.tap do
            m[q] = stanza_class_for(q).new(self).snippets
          end
        end
      end

      def initialize(holder, resolution)
        super(holder)
        self.resolution = resolution
      end

    end
  end
end
