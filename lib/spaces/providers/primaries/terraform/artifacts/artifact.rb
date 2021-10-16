module Artifacts
  module Terraform
    class Artifact < ::Artifacts::Artifact

      def stanza_qualifiers; [:container] ;end

    end
  end
end
