module Artifacts
  module Terraform
    module Aws
      module ContainerTaskDefinition
        class More < Snippet

          def content =
            %(
              execution_role_arn = aws_iam_role.#{qualification_for(:execution_role_binding)}.arn
              requires_compatibilities = #{compatibilities}
              container_definitions = jsonencode([
                #{definition_snippets}
              ])
            )

          def definition_snippets =  Definition.new(self).content

        end
      end
    end
  end
end
