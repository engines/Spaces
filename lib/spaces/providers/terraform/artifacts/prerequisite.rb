module Artifacts
  module Terraform
    class Prerequisite < Artifact

      def stanza_qualifiers; [:provider] ;end

    end
  end
end
