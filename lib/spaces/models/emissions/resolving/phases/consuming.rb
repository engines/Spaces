module Resolving
  module Consuming

    def as_consumer
      empty_consumer.tap do |m|
        m.struct = OpenStruct.new(milestones: the_milestones)
        m.struct.identifier = identifier
        m.cache_primary_identifiers
      end
    end

    def the_milestones
      direct_connections.map do |c|
        c.as_service.milestones
      end
    end

    def empty_consumer; consumer_class.new ;end
    def consumer_class; ::Commissioning::Consumer ;end

  end
end
