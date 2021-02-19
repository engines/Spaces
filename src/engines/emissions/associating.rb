module Emissions
  module Associating

    def associated
      empty.tap do |m|
        m.struct = OpenStruct.new(associating_division_structs) #.merge(struct)
        m.struct.identifier = identifier
      end
    end

    def associations; association_map.values ;end

    def associating_division_structs
      associating_division_map.transform_values(&:struct)
    end

    def associating_division_map
      association_map.merge(division_map)
    end

    def association_map
      @association_map ||= composition.associations.keys.inject({}) do |m, k|
        m.tap { m[k] = association_for(k) }
      end
    end

    def association_for(key)
      composition.associations[key]&.prototype(emission: self, label: key)
    end

  end
end
