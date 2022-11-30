require_relative 'resource'

module Artifacts
  module Aws
    class SubnetStanza < ResourceStanza

      class << self
        def default_configuration =
          super.merge(
            vpc_binding: :vpc,
            public: false
          )
      end

      def configuration_hash = super.without(:public)

    end
  end
end
