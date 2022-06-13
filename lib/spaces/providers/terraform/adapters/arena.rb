module Adapters
  module Terraform
    class Arena < ::Adapters::Arena

      def artifact_qualifiers
        [:prerequisites, :support]
      end

    end
  end
end
