module Artifacts
  module Terraform
    module Aws
      module RouteTable
        class Association < Snippet

          def content =
            %(
              subnet_id = aws_subnet.#{qualification_for(:subnet_binding)}.id
              route_table_id = aws_route_table.#{qualification_for(:route_table_binding)}.id
            )

        end
      end
    end
  end
end
