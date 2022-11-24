require_relative 'artifact'

module Artifacts
  module CloudFormation
    class Capsule < Artifact

      def capsule_type = [runtime_qualifier, 'container'].compact.join('_')

    end
  end
end
