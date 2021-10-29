module Artifacts
  module DockerCompose
    class Artifact < ::Artifacts::Provisioning::Artifact

      def stanza_qualifiers; [:container] ;end

      def filename; 'docker-compose' ;end


    end
  end
end
