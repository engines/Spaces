module Arenas
  class State < ::Spaces::Model

    relation_accessor :arena

    delegate(
      [:arenas, :blueprints, :installations, :resolutions, :packs, :provisioning] => :universe,
      [:identifier, :blueprinted] => :arena
    )

    def keys
      [
        :providers,
        :stale_bindings,
        :missing_blueprints,
        :uncomfirmed_installations, :stale_installations,
        :missing_resolutions, :stale_resolutions,
        :missing_packs, :stale_packs,
        :missing_provisioning, :stale_provisioning
      ]
    end

    def providers
       arena.provider_map.transform_values { |v| v.class.name }
    end

    def missing_blueprints; missing(:unblueprinted) ;end
    def uncomfirmed_installations; missing(:uninstalled) ;end
    def missing_resolutions; missing(:bindings_without_resolutions) ;end
    def missing_packs; missing(:unpacked) ;end
    def missing_provisioning; missing(:unprovisioned) ;end

    def missing(method); arena.send(method).map(&:identifier) ;end

    def stale_bindings
      blueprinted.select do |b|
        times(blueprints.modified_at(b), :>, modified_at)
      end.map(&:identifier)
    end

    def stale_installations; stale(:installed, installations) ;end
    def stale_resolutions; stale(:bindings_with_resolutions, resolutions) ;end
    def stale_packs; stale(:packed, packs) ;end
    def stale_provisioning; stale(:provisioned, provisioning) ;end

    def stale(method, space)
      arena.send(method).select do |b|
        times(space.modified_at(b.context_identifier), :<, modified_at)
      end.map(&:identifier).uniq
    end

    def modified_at; arenas.modified_at(arena) ;end

    def initialize(arena)
      self.arena = arena
      self.struct = _struct
    end

    protected

    def _struct
      OpenStruct.new(
        keys.inject({identifier: identifier}) do |m, k|
          m.tap { m[k] = send(k) }
        end
      ).compact
    end

  end
end
