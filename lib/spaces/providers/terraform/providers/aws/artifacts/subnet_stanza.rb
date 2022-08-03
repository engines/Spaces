require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class SubnetStanza < ResourceStanza

        class << self
          def default_configuration =
            OpenStruct.new(
              vpc_binding: :vpc
            )
        end

        def more_snippets =
          %(
            vpc_id = aws_vpc.#{configuration.vpc_binding}.id
          )

        def configuration_hash = super.without(:vpc_binding)

      end
    end
  end
end
