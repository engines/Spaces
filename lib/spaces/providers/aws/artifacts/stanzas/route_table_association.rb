require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class RouteTableAssociation < Resource

        def default_configuration =
          super.merge(
            subnet_binding: division.identifier,
            route_table_binding: default_binding
          )

      end
    end
  end
end
