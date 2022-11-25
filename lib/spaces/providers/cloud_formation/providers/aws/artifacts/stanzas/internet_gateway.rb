require_relative 'resource'

module Artifacts
  module CloudFormation
    module Aws
      class InternetGatewayStanza < ResourceStanza

        class << self
          def default_configuration =
            super.merge(
              vpc_binding: :vpc
            )
        end

        def more_snippets =
          {
            vpc_id: "aws_vpc.#{qualification_for(:vpc_binding)}.id"
          }

      end
    end
  end
end
