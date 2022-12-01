require_relative 'resource'

module Artifacts
  module Aws
    class IamRolePolicyStanza < ResourceStanza

      class << self
        def default_configuration =
          super.merge(
            role_binding: :'iam-role'
          )
      end

      def tags_snippet = nil

    end
  end
end
