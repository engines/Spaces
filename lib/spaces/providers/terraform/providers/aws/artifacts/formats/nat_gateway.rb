require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class NatGateway < Hcl

          def content =
            %(#{super}

              resource "aws_eip" "#{resource_identifier}" {
                vpc = true
              }
            )

          def more_snippets =
            %(
              subnet_id = aws_subnet.#{qualification_for(:subnet_binding)}.id
              allocation_id = aws_eip.#{qualification_for(:allocation_binding)}.id

              depends_on = [
                aws_internet_gateway.#{qualification_for(:internet_gateway_binding)}
              ]
            )

        end
      end
    end
  end
end
