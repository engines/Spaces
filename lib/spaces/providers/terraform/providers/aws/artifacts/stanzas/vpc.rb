require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class VpcStanza < ResourceStanza

        class << self
          def default_configuration =
            super.merge(
              cidr_block: nil,
        			enable_dns_support: true,
        			enable_dns_hostnames: false,
        			instance_tenancy: :default
            )
        end

      end
    end
  end
end
