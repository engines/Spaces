require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class RouteTable < Hash

          def name_snippet = nil

          def more_snippets =
            {
              vpc_id: qualification_for(:vpc_binding, :vpc),
              route: {
                cidr_block: '0.0.0.0/0'
              }.merge(gateway)
            }

          def gateway =
            unless nat_gateway?
              {gateway_id: qualification_for(:gateway_binding, :internet_gateway)}
            else
              {nat_gateway_id: qualification_for(:nat_gateway_binding, :nat_gateway)}
            end

        end
      end
    end
  end
end
