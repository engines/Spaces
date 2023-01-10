require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class ContainerTaskDefinition < Hcl

          def name_snippet = nil

          def more_snippets =
            %(
              execution_role_arn = aws_iam_role.#{qualification_for(:execution_role_binding)}.arn
              requires_compatibilities = #{compatibilities}
              container_definitions = jsonencode([
                #{definition_snippets}
              ])
            )

          def compatibilities =
            "#{container_services.map { |s| launch_type_for(s).to_s }.uniq}"

          def definition_snippets =
            container_services.map { |s| definition_snippet_for(s) }.join(",\n")

          def definition_snippet_for(r) =
            #TODO: hostPort must be the same as containerPort when netWorkMode is awsvpc
            %(
              {
                #{with_tailored_keys(hash_for(r)).to_hcl(enclosed:false)}
                networkMode = "#{configuration.network_mode}"
                portMappings = [
                  #{ports_mappings_for(r)}
                ]
              }
            )

        end
      end
    end
  end
end
