module Resolving
  module Servicing

    def as_service_for(consumer)
      empty_service.tap do |m|
        m.consumer = consumer
        m.struct.identifier = identifier
        m.cache_primary_identifiers
        m.struct.milestones = m.services
      end
    end

    def empty_service; service_class.new ;end
    def service_class; ::Commissioning::Service ;end

  end
end
