module Adapters
  module Terraform
    class Arena < ::Adapters::Arena

      def artifact_qualifiers
        # [:initial, :prerequisites, :zones]
        [:initial, :prerequisites]
      end

    end
  end
end
