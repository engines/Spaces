module Arenas
  class State < ::Spaces::Model

    relation_accessor :arena

    delegate(
      [:arenas, :blueprints, :installations, :resolutions, :packs, :provisioning] => :universe,
      [:identifier, :blueprinted] => :arena
    )

    def keys
      [
        # :initialized?, :fresh_initialization?,
        :providers,
        :missing_blueprints, :fresh_blueprints,
        :missing_installations, :fresh_installations,
        :missing_resolutions, :fresh_resolutions,
        :missing_packs, :fresh_packs, #:fresh_packing_attempt?,
        :missing_provisioning, :fresh_provisioning, #:fresh_provisioning_attempt?
      ]
    end

    # def initialized?; arenas.initial_file_name_for(arena).exist? ;end

    def providers
       arena.provider_map.transform_values { |v| v.class.name }
    end

    def missing_blueprints; missing(:unblueprinted) ;end
    def missing_installations; missing(:uninstalled) ;end
    def missing_resolutions; missing(:unresolved) ;end
    def missing_packs; missing(:unpacked) ;end
    def missing_provisioning; missing(:unprovisioned) ;end

    def missing(method); arena.send(method).map(&:identifier) ;end

    # def fresh_initialization?; times(initialized_at, :>, modified_at) ;end

    def fresh_blueprints
      blueprinted.
        map { |b| b.target_identifier }.
        select { |ti| times(blueprints.modified_at(ti), :>, modified_at) }.
        uniq
    end

    def fresh_installations; fresh(:installed, installations) ;end
    def fresh_resolutions; fresh(:resolved, resolutions) ;end
    def fresh_packs; fresh(:packed, packs) ;end
    def fresh_provisioning; fresh(:provisioned, provisioning) ;end

    def fresh(method, space)
      arena.send(method).
        map { |b| b.settlement_identifier_in(arena) }.
        select { |si| times(space.modified_at(si), :>, modified_at) }.
        uniq
    end

    def modified_at; arenas.modified_at(arena) ;end
    # def initialized_at; arenas.initialized_at(arena) ;end

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
