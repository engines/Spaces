require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class ApplicationLoadBalancerStanza < CapsuleStanza

        def snippets
          %(
            resource "aws_alb" "#{blueprint_identifier}" {
              name               = "${var.app_name}-${var.app_environment}-alb"
              internal           = false
              load_balancer_type = "application"
              subnets            = aws_subnet.public.*.id
              security_groups    = [aws_security_group.load_balancer_security_group.id]

              tags = {
                Name        = "${var.app_name}-alb"
                Environment = var.app_environment
              }
            }

            resource "aws_lb_target_group" "#{blueprint_identifier}_target_group" {
              name        = "${var.app_name}-${var.app_environment}-tg"
              port        = 80
              protocol    = "HTTP"
              target_type = "ip"
              vpc_id      = aws_vpc.aws-vpc.id

              health_check {
                healthy_threshold   = "3"
                interval            = "300"
                protocol            = "HTTP"
                matcher             = "200"
                timeout             = "3"
                path                = "/v1/status"
                unhealthy_threshold = "2"
              }

              tags = {
                Name        = "${var.app_name}-lb-tg"
                Environment = var.app_environment
              }
            }

            resource "aws_lb_listener" "#{blueprint_identifier}_listener" {
              load_balancer_arn = aws_alb.application_load_balancer.id
              port              = "8501"
              protocol          = "HTTP"

              default_action {
                type             = "forward"
                target_group_arn = aws_lb_target_group.target_group.id
              }
            }
          )
        end

      end
    end
  end
end
