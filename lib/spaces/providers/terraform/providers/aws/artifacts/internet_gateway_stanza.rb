require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class InternetGatewayStanza < ResourceStanza

        class << self
          def default_configuration =
            OpenStruct.new(
              vpc_binding: :vpc
            )
        end

        def configuration_snippet =
          %(
            vpc_id = aws_vpc.#{configuration.vpc_binding}.id
          )

        def configuration_hash = super.without(:vpc_binding)

      end
    end
  end
end
