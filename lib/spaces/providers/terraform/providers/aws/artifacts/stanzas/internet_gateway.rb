require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class InternetGatewayStanza < ResourceStanza

        class << self
          def default_configuration =
            super.merge(
              vpc_binding: :vpc
            )
        end

        def configuration_snippet =
          %(
            vpc_id = aws_vpc.#{qualifier_for(:vpc_binding)}.id
          )

        def configuration_hash = super.without(:vpc_binding)

      end
    end
  end
end
