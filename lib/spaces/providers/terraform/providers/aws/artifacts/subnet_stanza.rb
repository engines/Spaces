require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class SubnetStanza < ResourceStanza

        def more_snippets =
          %(
            vpc_id = aws_vpc.#{configuration.vpc_binding}.id
          )

        def configuration_hash = super.without(:vpc_binding)

        def default_configuration =
          OpenStruct.new(
            vpc_binding: :vpc
          )

      end
    end
  end
end
