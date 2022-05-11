module Adapters
  module Terraform
    class Orchestration < ::Adapters::Orchestration

      def artifact_qualifiers
        [:capsule]
      end

    end
  end
end
