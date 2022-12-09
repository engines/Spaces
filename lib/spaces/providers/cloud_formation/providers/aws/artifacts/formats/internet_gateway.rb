require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class InternetGateway < Hash

          def name_snippet = nil

          def more_snippets =
            {
              vpc_id: "aws_vpc.#{qualification_for(:vpc_binding)}.id"
            }

        end
      end
    end
  end
end
