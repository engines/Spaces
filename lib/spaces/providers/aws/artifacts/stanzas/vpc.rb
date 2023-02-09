require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class Vpc < Resource

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
