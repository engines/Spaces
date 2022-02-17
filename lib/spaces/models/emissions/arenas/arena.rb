require_relative 'prerequisites'
require_relative 'summary'

module Arenas
  class Arena < ::Emissions::Emission
    include ::Arenas::Prerequisites
    include ::Arenas::Binding
    include ::Arenas::Connecting
    include ::Arenas::Blueprinting
    include ::Arenas::Resolving
    include ::Arenas::Packing
    include ::Arenas::Provisioning
    include ::Arenas::Summary

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:arenas, :blueprints, :resolutions, :packs, :provisioning, :domains] => :universe,
    )

    def modified_at; arenas.modified_at(self) ;end

    def state
      @state ||= State.new(self)
    end

    def arena; self ;end

    def default_domains
      domains.all
    end

    def binding_class; ::Divisions::BindingInArena ;end

    def initialize(struct: nil, identifiable: nil)
      super.tap do
        self.struct[:input] ||= Input.new(emission: self, label: :input).struct
        self.struct[:domains] ||= default_domains.map(&:struct)
      end
    end

  end
end
