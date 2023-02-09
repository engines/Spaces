require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
    class IamRolePolicyAttachment < Resource

        class << self
          def default_configuration =
            super.merge(
              role_binding: :'iam-role',
              policy_arn: "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
            )
        end

      end
    end
  end
end
