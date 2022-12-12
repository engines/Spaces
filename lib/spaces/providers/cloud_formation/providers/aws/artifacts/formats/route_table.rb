require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class RouteTable < Hash

          def name_snippet = nil

          def more_snippets =
            {
              vpc_id: "aws_vpc.#{qualification_for(:vpc_binding)}.id",
              route: {
                cidr_block: '0.0.0.0/0'
              }.merge(gateway)
            }

          def gateway =
            unless nat_gateway?
              {gateway_id: "aws_internet_gateway.#{qualification_for(:gateway_binding)}.id"}
            else
              {nat_gateway_id: "aws_nat_gateway.#{qualification_for(:nat_gateway_binding)}.id"}
            end

          def more_snippets_keys = [:gateway_type]

        end
      end
    end
  end
end
