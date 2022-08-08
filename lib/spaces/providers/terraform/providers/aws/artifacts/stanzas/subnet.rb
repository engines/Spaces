require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class SubnetStanza < ResourceStanza

        class << self
          def default_configuration =
            super.merge(
              vpc_binding: :vpc
            )
        end

        def more_snippets =
          %(
            vpc_id = aws_vpc.#{qualifier_for(:vpc_binding)}.id
          )

        def configuration_hash = super.without(:vpc_binding)

      end
    end
  end
end
