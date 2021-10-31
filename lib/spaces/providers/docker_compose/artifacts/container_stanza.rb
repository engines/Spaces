module Artifacts
  module DockerCompose
    class ContainerStanza < ::Artifacts::Stanza

      relation_accessor :resolution

      def stanza_qualifiers
        [:build, :deploy]
      end

      def initialize(holder, resolution)
        super(holder)
        self.resolution = resolution
      end

    end
  end
end
