module Adapters
  module Terraform
    class Orchestration < ::Adapters::Orchestration

      def artifact_qualifiers
        [:resource]
      end

      def artifacts
        resourcer? ? [] : super
      end

    end
  end
end
