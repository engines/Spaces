module Emissions
  module Hashing

    def to_h
      division_map.keys.inject(identifiers) do |m, k|
        m.tap { m[k] = h_for(k) }
      end.compact
    end

    alias_method :to_h_deep, :to_h

    def identifiers = {identifier: identifier}

    def h_for(key) = division_map[key]&.to_h

  end
end
