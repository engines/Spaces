module Artifacts
  module Terraform
    module Aws
      class VariablesStanza < ::Artifacts::Stanza

        def snippets
          %(
            variable "aws_cloudwatch_retention_in_days" {
              type        = number
              description = "AWS CloudWatch Logs Retention in Days"
              default     = 1
            }

            variable "app_name" {
              type        = string
              description = "Application Name"
            }

            variable "public_subnets" {
              description = "List of public subnets"
            }

            variable "private_subnets" {
              description = "List of private subnets"
            }

            variable "availability_zones" {
              description = "List of availability zones"
            }
          )
        end

      end
    end
  end
end
