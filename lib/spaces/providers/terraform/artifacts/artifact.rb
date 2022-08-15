module Artifacts
  module Terraform
    class Artifact < ::Artifacts::Orchestrating::Artifact

      def filename =
        "#{emission.application_identifier}.#{qualifier}.#{extension}"

      def extension = :tf

      def dns_address =
        "#{container_type}.#{resource_identifier}.ipv4_address"

      def container_type =
        [runtime_qualifier, 'container'].compact.join('_')

    end
  end
end
