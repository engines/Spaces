module Artifacts
  module CloudFormation
    module Aws
      class Capsule < ::Artifacts::CloudFormation::Artifact

        def stanza_qualifiers =
          [compute_service_identifier || :capsule]

      end
    end
  end
end
