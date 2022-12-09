module Artifacts
  module CloudFormation
    class Artifact < ::Artifacts::Orchestrating::Artifact

      alias_method :content, :yaml_content

      #TODO: REFACTOR ... abstract up
      def filename =
        "#{emission.application_identifier}.#{qualifier}.#{extension}"

      def extension = :yaml

    end
  end
end
