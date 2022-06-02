module Artifacts
  module Terraform
    class Artifact < ::Artifacts::Orchestrating::Artifact

      def filename
        "#{emission.application_identifier}.#{extension}"
      end

      def extension; "tf.#{qualifier}" ;end

      def dns_address
        "#{container_type}.#{application_identifier}.ipv4_address"
      end

      def container_type
        [runtime_qualifier, 'container'].compact.join('_')
      end

    end
  end
end
