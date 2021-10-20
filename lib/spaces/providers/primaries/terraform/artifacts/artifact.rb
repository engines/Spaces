module Artifacts
  module Terraform
    class Artifact < ::Artifacts::Artifact

      def stanza_qualifiers; [:container, :volume, :dns] ;end

    end
  end
end
