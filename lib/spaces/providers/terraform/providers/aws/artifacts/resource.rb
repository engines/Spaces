module Artifacts
  module Terraform
    module Aws
      class Resource < ::Artifacts::Terraform::Resource

        def stanza_qualifiers
          [compute_service_identifier || :resource]
        end

      end
    end
  end
end
