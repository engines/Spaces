require_relative 'container_service'

module Artifacts
  module Aws
    module Stanzas
      class Service < ContainerService

        relation_accessor :compute_service

        delegate(emission: :compute_service)
        alias_method :resolution, :emission

        def resource_identifier =
          resolution.identifier.hyphenated

        def initialize(holder, compute_service)
          super(holder)
          self.compute_service = compute_service
        end

      end
    end
  end
end
