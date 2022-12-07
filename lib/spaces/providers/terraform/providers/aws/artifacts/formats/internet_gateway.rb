require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class InternetGateway < Hcl

          def name_snippet = nil

          def more_snippets =
            %(
              vpc_id = aws_vpc.#{qualification_for(:vpc_binding)}.id
            )

        end
      end
    end
  end
end
