require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class InternetGateway < Hash

          def name_snippet = nil

          def more_snippets =
            {
              vpc_id: qualification_for(:vpc_binding, :vpc)
            }

        end
      end
    end
  end
end
