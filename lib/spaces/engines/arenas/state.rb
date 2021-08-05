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
      [:configured?, :initialized?, :packer, :runtime, :runtime_bootstrapped?, :providers_bootstrapped, :missing_installations, :missing_resolutions, :missing_packs, :missing_provisions]
    end

    def configured?; has?(:configuration) ;end
    def initialized?; arenas.initial_file_name_for(self).exist? ;end
    def packer; packing_binding&.target_identifier ;end
    def runtime; runtime_binding&.target_identifier ;end
    def runtime_bootstrapped?; arenas.runtime_file_name_for(self).exist? ;end

    def providers_bootstrapped
      providers.select { |p| arenas.provider_file_name_for(p).exist? }.map(&:type)
    end

    def missing_installations; unsaved_installations.map(&:identifier) ;end #TODO: doesn't go deep
    def missing_resolutions; unsaved_resolutions.map(&:identifier) ;end #TODO: doesn't go deep
    def missing_packs; unsaved_packs.map(&:identifier) ;end #TODO: doesn't go deep
    def missing_provisions; unsaved_provisions.map(&:identifier) ;end #TODO: doesn't go deep

  end
end
