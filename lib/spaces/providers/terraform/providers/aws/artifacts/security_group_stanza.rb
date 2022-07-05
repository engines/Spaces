require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class SecurityGroupStanza < ResourceStanza

        def configuration_snippet
          %(
            ingress {
              from_port        = #{configuration.in_from_port}
              to_port          = #{configuration.in_to_port}
              protocol         = "#{configuration.in_protocol}"
              cidr_blocks      = #{configuration.in_cidr_blocks}
		      #{in_ivp6}
            }

            egress {
              from_port        = #{configuration.o_from_port}
              to_port          = #{configuration.o_to_port}
              protocol         = "#{configuration.o_protocol}"
              cidr_blocks      = #{configuration.o_cidr_blocks}
              ipv6_cidr_blocks = "#{configuration.o_ipv6_cidr_blocks}"
            }
          )
        end

       def default_configuration
          OpenStruct.new(
            description: application_identifier,
				in_from_port: 0,		
      			o_from_port: 0,
      			o_to_port: 0,
      			o_protocol: '-1',
      			o_cidr_blocks: ["0.0.0.0/0"],
				o_ipv6_cidr_blocks: ["::0"]
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
