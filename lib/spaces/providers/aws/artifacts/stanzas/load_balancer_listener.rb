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

        def certificate_arn =
          "arn:aws::#{region}:#{account_identifier}:certificate/487f72fc-0e54-4e57-82b2-fe152294cf29"

      end
    end
  end
end
