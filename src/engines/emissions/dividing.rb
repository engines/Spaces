module Emissions
  module Dividing

    def incomplete_divisions
      divisions.reject(&:complete?)
    end

    def mandatory_divisions_present?
      division_keys & mandatory_keys == mandatory_keys
    end

    def divisions; division_map.values ;end

    def count
      has?(:scaling) ? scaling.count : 1
    end

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m.tap { m[k] = division_for(k) }
      end.compact
    end

    def division_keys; division_map.keys ;end

    def division_for(key)
      composition.divisions[key]&.prototype(emission: self, label: key)
    end

  end
end
