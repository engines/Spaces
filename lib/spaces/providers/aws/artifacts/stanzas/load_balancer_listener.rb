require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class LoadBalancerListener < Resource

        class << self
          def default_configuration =
            super.merge(
              port: 443,
              protocol: 'HTTPS',
              ssl_policy: 'ELBSecurityPolicy-2016-08'
            )
        end

        def default_configuration =
          super.merge(
            target_group: resource_identifier,
            load_balancer: resource_identifier
          )

        def configuration_hash = super.without(:target_group, :load_balancer)

      end
    end
  end
end
