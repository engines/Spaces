module Resolving
  module Provisioning

    def provisioned
      empty_provisions.tap do |m|
        m.struct.identifier = identifier
        m.cache_primary_identifiers
      end
    end

    def provisionable?
      !defines_runtime_provider? & !defines_packing_provider?
    end

    def provisioned?
      provisioning.exist?(identifier)
    end

    def defines_runtime_provider?
      blueprint_identifier == runtime_binding&.target_identifier
    end

    def defines_packing_provider?
      blueprint_identifier == packing_binding&.target_identifier
    end

    def divisions_including_providers
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
