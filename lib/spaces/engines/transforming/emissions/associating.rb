module Emissions
  module Associating

    def associated
      empty.tap do |m|
        m.struct = OpenStruct.new(default_associating_map).merge(current_associating_structs)
        m.struct.identifier = identifier
      end
    end

    def associations; association_map.values ;end

    def current_associating_structs
      association_keys.inject({}) do |m, k|
        m.tap { m[k] = struct[k] }
      end.compact
    end

    def default_associating_map
      associating_division_map.transform_values(&:struct)
    end

    def associating_division_map
      association_map.merge(division_map)
    end

    def association_map
      @association_map ||= association_keys.inject({}) do |m, k|
        m.tap { m[k] = association_for(k) }
      end
    end

    def association_for(key)
      composition.associations[key]&.prototype(emission: self, label: key)
    end

    def association_keys; composition.associations.keys ;end

  end
end
