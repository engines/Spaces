require_relative 'resource'

module Artifacts
  module Aws
    class RouteTableAssociationStanza < ResourceStanza

      def default_configuration =
        super.merge(
          subnet_binding: resource.identifier,
          route_table_binding: default_binding
        )

      def tags_snippet = nil

    end
  end
end
