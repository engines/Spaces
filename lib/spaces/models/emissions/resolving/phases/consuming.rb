module Resolving
  module Consuming

    def as_consumer
      empty_consumer.tap do |m|
        m.predecessor = self
        m.cache_identifiers!
        m.struct.milestones = m.the_milestones
      end
    end

    def consumer
      @consumer ||= as_consumer
    end

    def empty_consumer = consumer_class.new
    def consumer_class = ::Commissioning::Consumer

  end
end
