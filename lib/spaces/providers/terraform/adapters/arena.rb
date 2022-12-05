module Adapters
  module Terraform
    class Arena < ::Adapters::Arena

      def artifact_qualifiers = [:providers]

    end
  end
end
