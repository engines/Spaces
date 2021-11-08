module Adapters
  module Terraform
    class Provisions < ::Adapters::Provisions

      def artifact_qualifiers
        [:container]
      end

    end
  end
end
