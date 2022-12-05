require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class Subnet < Hcl

          def name_snippet = nil

          def more_snippets =
            %(
              map_public_ip_on_launch = #{configuration.public}
              vpc_id = aws_vpc.#{qualification_for(:vpc_binding)}.id
            )

        end
      end
    end
  end
end
