module Adapters
  module CloudFormation
    class Arena < ::Adapters::Arena

      def artifact_qualifiers = [:providers, :support]
      # TODO: REFACTOR: abstract up

    end
  end
end
