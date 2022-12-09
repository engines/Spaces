require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class LoadBalancer < Hash

          def more_snippets =
            {
              subnets: subnet_identifiers,
              security_groups: security_group_identifiers,
              depends_on: dependency_array
            }

          def more_snippets_keys = [:subnets, :security_groups]

        end
      end
    end
  end
end
