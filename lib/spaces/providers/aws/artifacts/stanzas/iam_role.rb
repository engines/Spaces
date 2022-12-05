require_relative 'resource'

module Artifacts
  module Aws
    class IamRoleStanza < ResourceStanza

      def format
        @format ||= ::Artifacts::Terraform::Aws::Formats::IamRole.new(self)
      end

    end
  end
end
