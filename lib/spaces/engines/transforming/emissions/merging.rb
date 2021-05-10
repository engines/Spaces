module Emissions
  module Merging

    def merge(other)
      empty.tap do |m|
        m.predecessor = self
        m.struct = m.struct.merge(OpenStruct.new(merging_division_map(other)))
      end
    end

    def merging_division_map(other)
      merging_keys(other).inject({}) do |m, k|
        m.tap { m[k] = division_for(k).merge(other.division_for(k)) }
      end
    end

    def merging_keys(other)
      @merging_keys ||= [division_keys, other.division_keys].flatten.uniq
    end

  end
end
