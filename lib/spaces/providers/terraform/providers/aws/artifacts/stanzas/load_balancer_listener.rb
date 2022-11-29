require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class LoadBalancerListenerStanza < ResourceStanza

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

        def more_snippets = LoadBalancer::Listener.new(self).content

        def configuration_hash = super.without(:target_group, :load_balancer)

      end
    end
  end
end
