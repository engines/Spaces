require_relative 'artifact'

module Artifacts
  module Terraform
    class Arena < Artifact

      def filename
        "#{qualifier}.#{extension}"
      end

      def extension; "tf.#{qualifier}" ;end

    end
  end
end
