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
      including_provider_divisions.map { |d| d.blueprint_stanzas_for(self) }.flatten.compact
    end

    def including_provider_divisions
      [divisions, arena.provider_divisions].flatten.reject do |d|
        correlating_provider_classes.include?(d.class)
      end
    end

    def correlating_provider_classes
      @correlating_provider_classes ||=
        divisions.map(&:class).intersection(arena.provider_divisions.map(&:class))
    end

    def empty_provisions; provisions_class.new ;end
    def provisions_class; ::Provisioning::Provisions ;end

  end
end
