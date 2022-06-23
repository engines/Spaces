module Artifacts
  module Terraform
    module Aws
      class SubnetStanza < CapsuleStanza

        def more_snippets
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
