module Artifacts
  module Terraform
    module Aws
      module NatGateway
        class More < Snippet

        def content =
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
