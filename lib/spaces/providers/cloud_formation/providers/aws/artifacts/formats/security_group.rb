require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class SecurityGroup < Hash

          def more_snippets =
            {
              vpc_id: qualification_for(:vpc_binding, :vpc),
              ingress: {
                from_port: configuration.in_from_port,
                to_port: configuration.in_to_port,
                protocol: configuration.in_protocol,
                cidr_blocks: configuration.in_cidr_blocks
                #{in_ivp6}
              },
              egress: {
                from_port: configuration.out_from_port,
                to_port: configuration.out_to_port,
                protocol: configuration.out_protocol,
                cidr_blocks: configuration.out_cidr_blocks,
                ipv6_cidr_blocks: configuration.out_ipv6_cidr_blocks
              }
            }

        end
      end
    end
  end
end
