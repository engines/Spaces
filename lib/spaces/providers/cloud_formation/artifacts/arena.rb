require_relative 'artifact'

module Artifacts
  module CloudFormation
    class Arena < Artifact

      def filename = "#{qualifier}.#{extension}"

    end
  end
end
