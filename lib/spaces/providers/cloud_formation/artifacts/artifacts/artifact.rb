module Artifacts
  module CloudFormation
    class Artifact < ::Artifacts::Artifact

      alias_method :content, :yaml_content #TODO: consider ... this now depends on the format

      def stanza_qualifiers = [:template]

      def stanza_class_for(qualifier)
        class_for(:artifacts, :cloud_formation, :stanzas, qualifier)
      end

      #TODO: REFACTOR ... abstract up
      def filename = "cloud-formation.#{extension}"

      def extension = :yaml

    end
  end
end
