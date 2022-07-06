require_relative 'artifact'

module Artifacts
  module Terraform
    class Arena < Artifact

      def filename = "#{qualifier}.#{extension}"

    end
  end
end
