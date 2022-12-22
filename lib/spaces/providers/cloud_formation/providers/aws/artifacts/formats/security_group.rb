require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class SecurityGroup < Hash

          def more_snippets =
            {
              vpc_id: qualification_for(:vpc_binding, :vpc),
              security_group_ingress:
                configuration.in_cidr_blocks.map do |cb|
                  {
                    from_port: configuration.in_from_port,
                    to_port: configuration.in_to_port,
                    ip_protocol: configuration.in_protocol,
                    cidr_ip: cb
                    #{in_ivp6}
                  }
                end,
              security_group_egress:
                configuration.out_cidr_blocks.map do |cb|
                  {
                    from_port: configuration.out_from_port,
                    to_port: configuration.out_to_port,
                    ip_protocol: configuration.out_protocol,
                    cidr_ip: cb
                    #ipv6_cidr_blocks: configuration.out_ipv6_cidr_blocks
                  }
                end
            }

        end
      end
    end
  end
end
