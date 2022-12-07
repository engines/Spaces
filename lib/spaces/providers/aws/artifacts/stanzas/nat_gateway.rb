require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class NatGateway < Resource

        def default_configuration =
          super.merge(
            subnet_binding: resource.identifier,
            allocation_binding: resource.identifier,
            internet_gateway_binding: :internet_gateway
          )

      end
    end
  end
end
