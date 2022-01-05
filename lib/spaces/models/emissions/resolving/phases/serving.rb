module Resolving
  module Serving

    def as_service
      empty_service.tap do |m|
        m.struct = OpenStruct.new(milestones: services)
        m.struct.identifier = identifier
        m.cache_primary_identifiers
      end
    end

    def services
      []
    end

    def empty_service; service_class.new ;end
    def service_class; ::Commissioning::Service ;end

  end
end
