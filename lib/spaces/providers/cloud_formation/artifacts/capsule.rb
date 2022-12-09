require_relative 'artifact'

module Artifacts
  module CloudFormation
    class Capsule < Artifact

      # TODO: REFACTOR abstract up ?
      
      def stanza_qualifiers =
        [compute_service_identifier || :capsule]

      def capsule_type = [runtime_qualifier, 'container'].compact.join('_')

    end
  end
end
