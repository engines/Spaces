module Arenas
  class State < ::Spaces::Model

    relation_accessor :arena

    delegate(
      [:blueprints, :resolutions, :packs, :orchestrations] => :universe,
      [:identifier, :blueprinted, :modified_at] => :arena
    )

    def keys =
      [
        :providers,
        :stale_bindings,
        :missing_blueprints,
        :missing_resolutions, :stale_resolutions,
        :missing_packs, :stale_packs,
        :missing_orchestrations, :stale_orchestrations
      ]

    def providers = arena.providers.map { |p| p.class.name }

    def missing_blueprints = missing(:unblueprinted)
    def missing_resolutions = missing(:bindings_without_resolutions)
    def missing_packs = missing(:unpacked)
    def missing_orchestrations = missing(:unorchestrated)

    def missing(method) = arena.send(method).map(&:context_identifier)

    def stale_bindings
      blueprinted.select do |b|
        times(blueprints.modified_at(b), :>, modified_at)
      end.map(&:identifier)
    end

    def stale_resolutions = stale(:resolved, resolutions)
    def stale_packs = stale(:packed, packs)
    def stale_orchestrations = stale(:orchestrated, orchestrations)

    def stale(method, space)
      arena.send(method).select do |b|
        times(space.modified_at(b.context_identifier), :<, b.arena.modified_at)
      end.map(&:context_identifier).uniq
    end

    def initialize(arena)
      self.arena = arena
      self.struct = _struct
    end

    protected

    def _struct =
      OpenStruct.new(
        keys.inject({identifier: identifier}) do |m, k|
          m.tap { m[k] = send(k) }
        end
      ).compact

  end
end
