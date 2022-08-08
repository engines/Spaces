module Artifacts
  module Terraform
    module Aws
      class Resources < ::Artifacts::Terraform::Artifact

        def stanza_qualifiers = [:resources]

      end
    end
  end
end
