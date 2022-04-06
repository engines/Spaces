module Adapters
  module Terraform
    class Orchestration < ::Adapters::Orchestration

      def artifact_qualifiers
        [:container]
      end

    end
  end
end
