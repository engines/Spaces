module Artifacts
  module Terraform
    module Aws
      module Subnet
        class More < Snippet

          def content =
            %(
              map_public_ip_on_launch = #{configuration.public}
              vpc_id = aws_vpc.#{qualification_for(:vpc_binding)}.id
            )

        end
      end
    end
  end
end
