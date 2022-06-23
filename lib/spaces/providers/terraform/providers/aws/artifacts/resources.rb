module Artifacts
  module Terraform
    module Aws
      class Resources < ::Artifacts::Terraform::Artifact

        def stanza_qualifiers
          resolution.resources.map(&:type).uniq
        end

      end
    end
  end
end
