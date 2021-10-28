module Adapters
  module Terraform
    class Arena < ::Adapters::Arena

      def artifact_qualifiers
        # [:initial, :prerequisite, :zones]
        [:prerequisite]
      end

    end
  end
end
