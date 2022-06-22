module Adapters
  module Terraform
    class Orchestration < ::Adapters::Orchestration

      def artifact_qualifiers
        [:resource]
      end

    end
  end
end
