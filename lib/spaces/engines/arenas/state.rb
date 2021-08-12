module Arenas
  module State

    def state
      OpenStruct.new(
        state_keys.inject({identifier: identifier}) do |m, k|
          m.tap { m[k] = send(k) }
        end
      ).compact
    end

    def state_keys
      [
        :initialized?, :fresh_initialization?,
        :packer,
        :runtime,
        :runtime_bootstrapped?, :fresh_bootstrap?,
        :providers_bootstrapped, :fresh_providers,
        :missing_blueprints, :fresh_blueprints,
        :missing_installations, :fresh_installations,
        :missing_resolutions, :fresh_resolutions,
        :missing_packs, :fresh_packs, #:fresh_packing_attempt?,
        :missing_provisioning, :fresh_provisioning, #:fresh_provisioning_attempt?
      ]
    end

    def initialized?; arenas.initial_file_name_for(self).exist? ;end
    def packer; packing_binding&.target_identifier ;end
    def runtime; runtime_binding&.target_identifier ;end
    def runtime_bootstrapped?; arenas.runtime_file_name_for(self).exist? ;end

    def providers_bootstrapped
      other_providers.select { |p| arenas.provider_file_name_for(p).exist? }.map(&:type)
    end

    def missing_blueprints; missing(:unblueprinted) ;end
    def missing_installations; missing(:uninstalled) ;end
    def missing_resolutions; missing(:unresolved) ;end
    def missing_packs; missing(:unpacked) ;end
    def missing_provisioning; missing(:unprovisioned) ;end

    def missing(method); send(method).map(&:identifier) ;end

    def fresh_initialization?; times(initialized_at, :>, modified_at) ;end
    def fresh_bootstrap?; times(bootstrapped_at, :>, modified_at) ;end

    def fresh_providers
      other_providers.select do |p|
        times(arenas.provider_file_name_for(p).mtime, :>, modified_at)
      end.map(&:type)
        times(arenas.provider_file_name_for(p).exist_then(&:mtime), :>, modified_at)
    end

    def fresh_blueprints
      blueprinted.
        map { |b| b.target_identifier }.
        select { |ti| times(blueprints.modified_at(ti), :>, modified_at) }
    end

    def fresh_installations; fresh(:installed, installations) ;end
    def fresh_resolutions; fresh(:resolved, resolutions) ;end
    def fresh_packs; fresh(:packed, packs) ;end
    def fresh_provisioning; fresh(:provisioned, provisioning) ;end

    def fresh(method, space)
      send(method).
        map { |b| b.settlement_identifier_in(self) }.
        select { |si| times(space.modified_at(si), :>, modified_at) }
    end

    def exist?; arenas.exist?(self) ;end
    def modified_at; arenas.modified_at(self) ;end
    def initialized_at; arenas.initialized_at(self) ;end
    def bootstrapped_at; arenas.bootstrapped_at(self) ;end

  end
end
