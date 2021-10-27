module Artifacts
  module Terraform
    class Artifact < ::Artifacts::Provisioning::Artifact

      def extension; "tf.#{super}" ;end

    end
  end
end
