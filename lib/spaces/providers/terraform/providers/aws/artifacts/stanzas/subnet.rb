require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class SubnetStanza < ResourceStanza

        class << self
          def default_configuration =
            super.merge(
              vpc_binding: :vpc,
              public: false
            )
        end

        def more_snippets =
          %(
            # map_public_ip_on_launch = #{configuration.public}
            vpc_id = aws_vpc.#{qualification_for(:vpc_binding)}.id
          )

        def configuration_hash = super.without(:public)

      end
    end
  end
end
