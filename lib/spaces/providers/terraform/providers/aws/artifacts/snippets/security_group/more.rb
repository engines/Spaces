module Artifacts
  module Terraform
    module Aws
      module SecurityGroup
        class More < Snippet

          def content =
            %(
              vpc_id = aws_vpc.#{qualification_for(:vpc_binding)}.id
              ingress {
                from_port        = #{configuration.in_from_port}
                to_port          = #{configuration.in_to_port}
                protocol         = "#{configuration.in_protocol}"
                cidr_blocks      = #{configuration.in_cidr_blocks}
                #{in_ivp6}
              }

              egress {
                from_port        = #{configuration.out_from_port}
                to_port          = #{configuration.out_to_port}
                protocol         = "#{configuration.out_protocol}"
                cidr_blocks      = #{configuration.out_cidr_blocks}
                ipv6_cidr_blocks = #{configuration.out_ipv6_cidr_blocks}
              }
            )

        end
      end
    end
  end
end
