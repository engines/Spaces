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
            vpc_id = aws_vpc.#{arena_attachable_qualification_for(:vpc_binding)}.id
          )

      end
    end
  end
end
