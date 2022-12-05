require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class RouteTableAssociation < Hcl

          def name_snippet = nil
          def tags_snippet = nil

          def more_snippets =
            %(
              subnet_id = aws_subnet.#{qualification_for(:subnet_binding)}.id
              route_table_id = aws_route_table.#{qualification_for(:route_table_binding)}.id
            )

        end
      end
    end
  end
end
