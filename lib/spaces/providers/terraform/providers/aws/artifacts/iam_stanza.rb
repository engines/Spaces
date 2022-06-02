require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class IamStanza < CapsuleStanza

        def snippets
          %(
            resource "aws_iam_role" "#{application_identifier}_role" {
              name               = "${var.app_name}-execution-task-role"
              assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
              tags = {
                Name        = "${var.app_name}-iam-role"
              }
            }

            data "aws_iam_policy_document" "#{application_identifier}_policy_document" {
              statement {
                actions = ["sts:AssumeRole"]

                principals {
                  type        = "Service"
                  identifiers = ["ecs-tasks.amazonaws.com"]
                }
              }
            }

            resource "aws_iam_role_policy_attachment" "#{application_identifier}_policy_attachment" {
              role       = aws_iam_role.ecsTaskExecutionRole.name
              policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"

            }
          )
        end

      end
    end
  end
end
