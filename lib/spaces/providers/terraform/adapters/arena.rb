module Adapters
  module Terraform
    class Arena < ::Adapters::Arena

      def artifact_qualifiers
        [:initial, :prerequisites, :zones]
      end

    end
  end
end
