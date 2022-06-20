module Artifacts
  module Terraform
    module Aws
      class InternetGatewayStanza < CapsuleStanza

        def configuration_snippet
          %(
            vpc_id = aws_vpc.#{configuration.vpc_binding}.id
          )
        end

        def configuration_hash
          super.without(:vpc_binding)
        end

        def default_configuration
          OpenStruct.new(
            vpc_binding: :vpc
          )
        end

      end
    end
  end
end
