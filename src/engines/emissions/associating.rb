module Emissions
  module Associating

    def associated
      empty.tap do |m|
        m.struct = OpenStruct.new(association_structs).merge(struct)
      end
    end

    def association_structs
      @association_structs ||= associating_map.keys.inject({}) do |m, k|
        m.tap { m[k] = associating_map[k].struct }
      end
    end

    def associations; associating_map.values ;end

    def associating_map
      @associating_map ||= composition.associations.keys.inject({}) do |m, k|
        m.tap { m[k] = association_for(k) }
      end
    end

    def association_for(key)
      composition.associations[key]&.prototype(emission: self, label: key)
    end

  end
end
