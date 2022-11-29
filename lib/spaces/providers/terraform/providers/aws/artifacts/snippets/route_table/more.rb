module Artifacts
  module Terraform
    module Aws
      module RouteTable
        class More < Snippet

          def content =
            %(
              vpc_id = aws_vpc.#{qualification_for(:vpc_binding)}.id
              route {
                cidr_block = "0.0.0.0/0"
                #{gateway}
              }
            )

          def gateway =
            unless nat_gateway?
              "gateway_id = aws_internet_gateway.#{qualification_for(:gateway_binding)}.id"
            else
              "nat_gateway_id = aws_nat_gateway.#{qualification_for(:nat_gateway_binding)}.id"
            end

        end
      end
    end
  end
end
