module Resolving
  module Provisioning

    def provisioned
      empty_provisions.tap do |m|
        m.predecessor = self
        m.struct.identifier = identifier
      end
    end

    def resolvable?
      !bootstrap?
    end

    def provisionable?
      !(bootstrap? || defines_runtime?)
    end

    def bootstrap?
      arena.bindings.map(&:identifier).include?(blueprint_identifier)
    end

    def defines_runtime?
      blueprint_identifier == runtime_binding&.target_identifier
    end

    def divisions_including_provider_divisions
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
