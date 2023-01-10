require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class ContainerTaskDefinition < Hash

          def name_snippet = nil

          def more_snippets =
            {
              execution_role_arn: execution_role_arn,
              requires_compatibilities: compatibilities,
              container_definitions: definition_snippets
            }

          def execution_role_arn =
            # TODO: needs to be single-quoted?
            "arn:aws:iam::#{account_identifier}:role/#{qualification_for(:execution_role_binding)}"

          def compatibilities =
            container_services.map { |s| launch_type_for(s) }.uniq

          def definition_snippets =
            container_services.inject({}) { |m, s| m.merge(definition_snippet_for(s)) }

          def definition_snippet_for(r) =
            #TODO: hostPort must be the same as containerPort when netWorkMode is awsvpc
            with_tailored_keys(hash_for(r)).merge(
              {
                networkMode: configuration.network_mode,
                portMappings: ports_mappings_for(r)
              }
            )

        end
      end
    end
  end
end
