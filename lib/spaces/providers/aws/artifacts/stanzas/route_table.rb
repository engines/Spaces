require_relative 'resource'

module Artifacts
  module Aws
    class RouteTableStanza < ResourceStanza

      class << self
        def default_configuration =
          super.merge(
            vpc_binding: :vpc,
            gateway_binding: :'internet-gateway'
          )
      end

      def nat_gateway? = resource.struct&.configuration&.gateway_type == 'nat'

      def default_configuration =
        super.merge(
          nat_gateway_binding: nat_gateway_identifier
        )

      def nat_gateway_identifier =
        if nat_gateway?
          :"#{resource.struct[:identifier] || configuration.gateway_binding}"
        end

      def more_snippets_keys = [:gateway_type]

    end
  end
end
