module Emissions
  module Dividing

    def incomplete_divisions
      divisions.reject(&:complete?)
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
