require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class SecurityGroupStanza < CapsuleStanza

        def snippets
          %(
            resource "aws_security_group" "load_balancer_security_group" {
              vpc_id = aws_vpc.aws-vpc.id

              ingress {
                from_port        = 8501
                to_port          = 8501
                protocol         = "tcp"
                cidr_blocks      = ["0.0.0.0/0"]
                ipv6_cidr_blocks = ["::/0"]
              }

              egress {
                from_port        = 0
                to_port          = 0
                protocol         = "-1"
                cidr_blocks      = ["0.0.0.0/0"]
                ipv6_cidr_blocks = ["::/0"]
              }
              tags = {
                Name        = "${var.app_name}-sg"
                Environment = var.app_environment
              }
            }
          )
        end

      end
    end
  end
end
