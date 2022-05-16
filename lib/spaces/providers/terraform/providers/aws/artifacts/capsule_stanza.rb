module Artifacts
  module Terraform
    module Aws
      class CapsuleStanza < ::Artifacts::Terraform::CapsuleStanza

        def snippets
          "# capsule resource snippet for #{blueprint_identifier} with nothing to say."
        end

      end
    end
  end
end
