module Adapters
  module Terraform
    class Arena < ::Adapters::Arena

      def artifact_qualifiers
        [:initial, :prerequisites, :support]
      end

    end
  end
end
