module Artifacts
  module Terraform
    module Aws
      class Resources < ::Artifacts::Terraform::Artifact

        def stanza_qualifiers
          [compute_service_identifier || :resources]
        end

      end
    end
  end
end
