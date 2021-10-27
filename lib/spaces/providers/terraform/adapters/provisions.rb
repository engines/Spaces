module Adapters
  module Terraform
    class Provisions < ::Adapters::Provisions

      def artifact_qualifiers
        # [:container, :initial, :prerequisites, :zones]
        [:container, :prerequisites, :zones]
      end

    end
  end
end
