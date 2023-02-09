require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class IamRolePolicy < Resource

        class << self
          def default_configuration =
            super.merge(
              role_binding: :'iam-role'
            )
        end

      end
    end
  end
end
