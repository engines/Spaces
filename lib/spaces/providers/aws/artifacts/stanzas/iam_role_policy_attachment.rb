require_relative 'resource'

module Artifacts
  module Aws
    class IamRolePolicyAttachmentStanza < ResourceStanza

      class << self
        def default_configuration =
          super.merge(
            role_binding: :'iam-role',
            policy_arn: "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
          )
      end

      def tags_snippet = nil

    end
  end
end
