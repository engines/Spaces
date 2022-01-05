module Resolving
  module Consuming

    def as_consumer
      empty_consumer.tap do |m|
        m.struct.identifier = identifier
        m.cache_primary_identifiers
        m.struct = OpenStruct.new(milestones: m.the_milestones)
      end
    end

    def empty_consumer; consumer_class.new ;end
    def consumer_class; ::Commissioning::Consumer ;end

  end
end
