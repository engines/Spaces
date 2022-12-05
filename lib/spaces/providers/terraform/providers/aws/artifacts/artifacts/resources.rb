module Artifacts
  module Terraform
    class Resources < ::Artifacts::Terraform::Artifact

      def stanza_qualifiers = [:resources]

    end
  end
end
