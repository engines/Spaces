require_relative 'artifact'

module Artifacts
  module Terraform
    class Arena < Artifact

      #TODO: REFACTOR ... abstract up
      def filename = "#{qualifier}.#{extension}"

    end
  end
end
