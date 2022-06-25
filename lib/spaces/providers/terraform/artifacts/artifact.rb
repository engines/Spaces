module Artifacts
  module Terraform
    class Artifact < ::Artifacts::Orchestrating::Artifact

      def filename
        "#{emission.application_identifier}.#{qualifier}.#{extension}"
      end

      def extension; :tf ;end

      def dns_address
        "#{container_type}.#{application_identifier}.ipv4_address"
      end

      def container_type
        [runtime_qualifier, 'container'].compact.join('_')
      end

    end
  end
end
