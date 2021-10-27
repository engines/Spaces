module Artifacts
  module Terraform
    class Artifact < ::Artifacts::Provisioning::Artifact

      def filename
        "#{emission.blueprint_identifier}.#{extension}"
      end

      def extension; "tf.#{qualifier}" ;end

    end
  end
end
