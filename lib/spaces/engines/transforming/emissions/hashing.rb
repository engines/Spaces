module Emissions
  module Hashing

    def to_h
      division_map.keys.inject({identifier: identifier}) do |m, k|
        m.tap { m[k] = h_for(k) }
      end.compact
    end

    def h_for(key)
      division_map[key]&.to_h
    end

  end
end
