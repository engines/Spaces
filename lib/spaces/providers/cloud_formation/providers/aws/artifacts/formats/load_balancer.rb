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
              depends_on: dependency_identifiers
            }

          def subnet_identifiers =
            configuration.subnets.map { |s| qualification_for(s, type_for(:subnet)) }

          def security_group_identifiers =
            configuration.security_groups.map { |g| qualification_for(g, type_for(:security_group)) }

          def dependency_identifiers =
            [subnet_identifiers, security_group_identifiers].flatten

          def qualification_for(identifier, type) =
            [identifier, type].join('_').underscore.camelize

        end
      end
    end
  end
end
