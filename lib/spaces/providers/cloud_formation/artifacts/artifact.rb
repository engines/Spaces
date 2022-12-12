module Artifacts
  module CloudFormation
    class Artifact < ::Artifacts::Artifact

      alias_method :content, :yaml_content #TODO: consider ... this now depends on the format

      #TODO: REFACTOR ... abstract up
      def filename =
        "#{emission.application_identifier}.#{qualifier}.#{extension}"

      def extension = :yaml

    end
  end
end
