module Resolving
  module Servicing

    def as_service_for(consumer)
      empty_service.tap do |m|
        m.resolution = self
        m.consumer = consumer
        m.cache_identifiers!
        m.struct.milestones = m.services
      end
    end

    def empty_service = service_class.new
    def service_class = ::Commissioning::Service

  end
end
