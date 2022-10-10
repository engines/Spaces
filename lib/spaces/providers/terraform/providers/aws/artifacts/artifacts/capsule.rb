module Artifacts
  module Terraform
    module Aws
      class Capsule < ::Artifacts::Terraform::Artifact

        def stanza_qualifiers =
          [compute_service_identifier || :capsule]

      end
    end
  end
end
