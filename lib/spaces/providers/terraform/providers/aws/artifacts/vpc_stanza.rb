module Artifacts
  module Terraform
    module Aws
      class VpcStanza < CapsuleStanza

        def default_configuration
          OpenStruct.new(
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
