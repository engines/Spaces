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
      divisions.map(&:blueprint_stanzas).flatten.compact
    end

    def empty_provisions; provisions_class.new ;end
    def provisions_class; ::Provisioning::Provisions ;end

  end
end
