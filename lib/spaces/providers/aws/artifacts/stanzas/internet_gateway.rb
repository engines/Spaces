require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class InternetGateway < Resource

        class << self
          def default_configuration =
            super.merge(
              vpc_binding: :vpc
            )
        end

      end
    end
  end
end
