module Resolving
  module Commissioning

    def as_commission
      empty_commission.tap do |m|
        m.struct.identifier = identifier
        m.cache_primary_identifiers
      end
    end

    def commission
      @commission ||= as_commission
    end

    def empty_commission; commission_class.new ;end
    def commission_class; ::Commissioning::Commission ;end

  end
end
