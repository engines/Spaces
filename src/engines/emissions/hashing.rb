module Emissions
  module Hashing

    def to_h
      keys.inject({}) do |m, k|
        m.tap { m[k] = h_for(k) }
      end.compact
    end

    def h_for(key)
      (division_map[key] || struct[key]).to_h
    end

  end
end
