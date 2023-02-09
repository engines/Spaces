module Artifacts
  module DockerCompose
    class Artifact < ::Artifacts::Artifact

      alias_method :content, :yaml_content #TODO: consider ... this now depends on the format

      def stanza_qualifiers = [:services]

      def compute_qualifier = :docker_compose

      #TODO: REFACTOR ... abstract up
      def filename = "docker-compose.#{extension}"

      def extension = :yaml

    end
  end
end
