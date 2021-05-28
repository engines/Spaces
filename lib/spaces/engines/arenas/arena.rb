require_relative 'binding'
require_relative 'providing'
require_relative 'resolving'
require_relative 'packing'
require_relative 'provisioning'

module Arenas
  class Arena < ::Emissions::Emission
    include ::Arenas::Binding
    include ::Arenas::Providing
    include ::Arenas::Resolving
    include ::Arenas::Packing
    include ::Arenas::Provisioning

    class << self
      def composition_class; Composition ;end
    end

    delegate([:arenas, :blueprints] => :universe)

    def more_organization_identifiers
      blueprints.organization_identifiers - target_identifiers
    end

    def runtime_binding
      @runtime_binding ||= deep_bindings.detect(&:runtime_binding?)
    end

    def packing_binding
      @packing_binding ||= deep_bindings.detect(&:packing_binding?)
    end

    def arena; itself ;end

    def method_missing(m, *args, &block)
      provider_map["#{m}"] || super
    end

    def respond_to_missing?(m, *)
      provider_map.keys.include?("#{m}") || super
    end

  end
end
