module Divisions
  module Dividing

    def incomplete_divisions
      divisions.reject(&:complete?)
    end

    def bindings; important_division(:bindings) ;end
    def binding_target; important_division(:binding_target) ;end
    def images; important_division(:images) ;end
    def volumes; important_division(:volumes) ;end

    def important_division(key)
      has?(key) ? division_map[key] : division_for(key)
    end

    def divisions; division_map.values ;end

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m.tap { m[k] = division_for(k) }
      end.compact
    end

    def division_keys; division_map.keys ;end

    def division_for(key)
      associations_and_divisions[key]&.prototype(emission: self, label: key)
    end

  end
end
