module Divisions
  module Dividing

    def incomplete_divisions
      divisions.reject(&:complete?)
    end

    def connections; important_division_for(:connections) ;end

    def configuration; important_division_for(:configuration) ;end
    def bindings; important_division_for(:bindings) ;end # NOW WHAT?
    def binding_target; important_division_for(:binding_target) ;end
    def images; important_division_for(:images) ;end
    def volumes; important_division_for(:volumes) ;end

    def important_division_for(key)
      has?(key) ? division_map[key] : division_for(key)
    end

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m.tap { m[k] = division_for(k) }
      end.compact
    end

    def divisions; division_map.values ;end
    def division_keys; division_map.keys ;end

    def division_for(key)
      associations_and_divisions[key]&.prototype(emission: self, label: key)
    end

  end
end
