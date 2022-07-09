module Adapters
  module Terraform
    class Arena < ::Adapters::Arena

      def artifact_qualifiers = [:providers, :support]

    end
  end
end
