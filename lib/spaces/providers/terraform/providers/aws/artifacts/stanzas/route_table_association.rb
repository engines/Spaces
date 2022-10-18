require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class RouteTableAssociationStanza < ResourceStanza

        def default_configuration =
          super.merge(
            subnet_binding: resource.identifier,
            # subnet_binding: :'public-a',
            route_table_binding: :'route-table'
          )

        def resource_identifier =
          [arena.identifier, application_identifier, resource.identifier].join('-').hyphenated.abbreviated_to(maximum_identifier_length)

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
