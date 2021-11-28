require_relative 'prerequisites'
require_relative 'summary'

module Arenas
  class Arena < ::Emissions::Emission
    include ::Arenas::Prerequisites
    include ::Arenas::Binding
    include ::Arenas::Connecting
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

    def state
      @state ||= State.new(self)
    end

    def arena; self ;end

    def initialize(struct: nil, identifiable: nil)
      super.tap do
        self.struct[:input] ||= Input.new(emission: self, label: :input).struct
      end
    end

  end
end
