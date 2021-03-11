module Resolving
  module Provisioning

    def provisioned
      empty_provisions.tap do |m|
        m.predecessor = self
        m.struct.identifier = identifier
      end
    end

    def stanzas_content; stanzas.join("\n") ;end

    def stanzas
      divisions_with_provider_divisions.map { |d| d.blueprint_stanzas_for(self) }.flatten.compact
    end

    def divisions_with_provider_divisions
      [divisions, arena.provider_divisions].flatten.compact.uniq(&:class)
    end

    def empty_provisions; provisions_class.new ;end
    def provisions_class; ::Provisioning::Provisions ;end

  end
end
