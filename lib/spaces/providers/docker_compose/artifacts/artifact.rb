module Artifacts
  module DockerCompose
    class Artifact < ::Artifacts::Orchestrating::Artifact

      alias_method :content, :yaml_content

      def stanza_qualifiers; [:services] ;end

      def filename
        "docker-compose.#{extension}"
      end

      def extension; :yaml ;end

    end
  end
end
