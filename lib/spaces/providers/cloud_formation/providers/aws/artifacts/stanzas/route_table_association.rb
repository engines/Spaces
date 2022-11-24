require_relative 'resource'

module Artifacts
  module CloudFormation
    module Aws
      class RouteTableAssociationStanza < ResourceStanza

        def default_configuration =
          super.merge(
            subnet_binding: resource.identifier,
            route_table_binding: default_binding
          )

        def more_snippets =
          %(
            subnet_id = aws_subnet.#{qualification_for(:subnet_binding)}.id
            route_table_id = aws_route_table.#{qualification_for(:route_table_binding)}.id
          )

        def tags_snippet = nil

      end
    end
  end
end
