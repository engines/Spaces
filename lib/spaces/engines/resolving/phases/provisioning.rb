module Resolving
  module Provisioning

    def provisioned
      empty_provisions.tap do |m|
        m.struct.identifier = identifier
        m.cache_primary_identifiers
      end
    end

    def provisioned?
      provisioning.exist?(identifier)
    end

    def empty_provisions; provisions_class.new ;end
    def provisions_class; ::Provisioning::Provisions ;end

  end
end
