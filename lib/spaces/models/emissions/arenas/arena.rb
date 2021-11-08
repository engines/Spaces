require_relative 'prerequisites'
require_relative 'summary'

module Arenas
  class Arena < ::Emissions::Emission
    include ::Arenas::Prerequisites
    include ::Arenas::Binding
    include ::Arenas::Blueprinting
    include ::Arenas::Installing
    include ::Arenas::Resolving
    include ::Arenas::Packing
    include ::Arenas::Provisioning
    include ::Arenas::Summary

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:arenas, :blueprints, :installations, :resolutions, :packs, :provisioning] => :universe,
    )

    def more_binder_identifiers
      blueprints.binder_identifiers - target_identifiers
    end

    def connectable_blueprints
      connected_blueprints.map do |b|
        b.binder? ? b.connected_blueprints.flatten.map(&:blueprint) : b
      end.flatten.uniq(&:uniqueness)
    end

    def state
      @state ||= State.new(self)
    end

    def arena; self ;end

  end
end
