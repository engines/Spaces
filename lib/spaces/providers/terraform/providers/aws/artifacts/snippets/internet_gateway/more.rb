module Artifacts
  module Terraform
    module Aws
      module InternetGateway
        class More < Snippet

          def content =
            %(
              vpc_id = aws_vpc.#{qualification_for(:vpc_binding)}.id
            )

        end
      end
    end
  end
end
