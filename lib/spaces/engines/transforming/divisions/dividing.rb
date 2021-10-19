module Divisions
  module Dividing

    def incomplete_divisions
      divisions.reject(&:complete?)
    end

    def bindings; mandatory_division_for(:bindings) ;end
    def binding_target; mandatory_division_for(:binding_target) ;end
    def images; mandatory_division_for(:images) ;end
    def volumes; mandatory_division_for(:volumes) ;end

    def mandatory_division_for(key)
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
