require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class SecurityGroupStanza < ResourceStanza

        def more_snippets
          %(
            ingress {
              from_port        = #{in_from_port}
              to_port          = #{configuration.in_to_port}
              protocol         = "#{configuration.in_protocol}"
              cidr_blocks      = #{configuration.in_cidr_blocks}
		      #{in_ivp6}
            }

            egress {
              from_port        = #{o_from_port}
              to_port          = #{o_to_port}
              protocol         = "#{o_protocol}"
              cidr_blocks      = #{o_cidr_blocks}
              #{o_ivp6}
            }
          )
        end

        def in_ivp6
          %(configuration.in_ipv6_cidr_blocks #{configuration.in_ipv6_cidr_blocks}) if configuration.in_ipv6_cidr_blocks
        end
        
        def  o_ivp6
          configuration.o_ipv6_cidr_blocks ?  %(ipv6_cidr_blocks = ["configuration.o_ipv6_cidr_blocks"])  : %(ipv6_cidr_blocks = ["::/0"]) 
        end
        
        def o_from_port
          configuration.o_from_port ? configuration.o_from_port : 0
        end
        
        def o_to_port
         configuration.o_to_port ? configuration.o_to_port : 0
        end
        
        def o_protocol
         configuration.o_protocol ? configuration.o_protocol : "-1"
        end
        
        def o_cidr_blocks
         configuration.o_cidr_blocks ? configuration.o_cidr_blocks : ["0.0.0.0/0"]
        end

       def in_from_port
         configuration.in_from_port  ? configuration.in_from_port : 0
       end 

      end
    end
  end
end
