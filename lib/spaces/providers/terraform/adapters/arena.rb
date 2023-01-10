module Adapters
  module Terraform
    class Arena < ::Adapters::Arena

      # TODO: REFACTOR: abstract up
      def artifact_qualifiers = [:providers]

    end
  end
end
