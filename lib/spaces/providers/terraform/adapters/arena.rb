module Adapters
  module Terraform
    class Arena < ::Adapters::Arena

      def artifact_qualifiers
        # [:initial, :prerequisites, :zones]
        [:prerequisites]
      end

    end
  end
end
