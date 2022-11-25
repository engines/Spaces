module Artifacts
  module Aws
    class Capsule < ::Artifacts::Artifact

      def stanza_qualifiers =
        [compute_service_identifier || :capsule]

    end
  end
end
