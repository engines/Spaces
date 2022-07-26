require_relative 'providing'
require_relative 'resourcing'
require_relative 'summary'
require_relative 'relations'

module Arenas
  class Arena < ::Emissions::Emission
    include Images
    include Providing
    include Binding
    include Connecting
    include Blueprinting
    include Resolving
    include Packing
    include Orchestrating
    include Resourcing
    include Summary
    include Relations

    class << self
      def composition_class = Composition
    end

    delegate(
      [:arenas, :blueprints, :resolutions, :packs, :orchestrations, :domains] => :universe,
      descendant_paths: :connections
    )

    def state
      @state ||= State.new(self)
    end

    def arena = self

    def default_domains = domains.all

    def resolution_default_division_keys = [:images]

    def binding_class = ::Divisions::BindingInArena

    def initialize(struct: nil, identifiable: nil)
      super.tap do
        self.struct[:input] ||= Input.new(emission: self, label: :input).struct
        self.struct[:domains] ||= default_domains.map(&:struct)
      end
    end

  end
end
