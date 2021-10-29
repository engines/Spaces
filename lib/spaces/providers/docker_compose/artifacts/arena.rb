require_relative 'artifact'

module Artifacts
  module DockerCompose
    class Arena < Artifact

      def filename
        "#{qualifier}.#{extension}"
      end

      def extension; "tf.#{qualifier}" ;end

    end
  end
end
