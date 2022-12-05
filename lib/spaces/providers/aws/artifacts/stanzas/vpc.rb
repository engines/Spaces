require_relative 'resource'

module Artifacts
  module Aws
    class VpcStanza < ResourceStanza

      class << self
        def default_configuration =
          super.merge(
            cidr_block: nil,
      			enable_dns_support: true,
      			enable_dns_hostnames: false,
      			instance_tenancy: :default
          )
      end

      def format
        @format ||= ::Artifacts::Terraform::Aws::Formats::Vpc.new(self)
      end

    end
  end
end
