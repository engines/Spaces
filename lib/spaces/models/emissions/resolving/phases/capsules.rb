module Resolving
  module Capsules

    def to_capsule
      empty_capsule.tap do |m|
        m.predecessor = self
        m.cache_primary_identifiers!
      end
    end

    def empty_capsule; capsule_class.new ;end
    def capsule_class; ::Capsules::Capsule ;end

  end
end
