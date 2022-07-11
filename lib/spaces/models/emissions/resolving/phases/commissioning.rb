module Resolving
  module Commissioning

    def as_commission
      empty_commission.tap do |m|
        m.predecessor = self
        m.cache_identifiers!
      end
    end

    def commission
      @commission ||= as_commission
    end

    def empty_commission = commission_class.new
    def commission_class = ::Commissioning::Commission

  end
end
