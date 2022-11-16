require_relative 'division'

module Divisions
  class KeyedDivision < Division

    def inflated = self
    def deflated = self

    def embedded_with(other)
      duplicate(itself).tap do |d|
        keys_including(other).each do |k|
          d.struct[k] = [other.struct[k], d.struct[k]].flatten.compact.uniq
        end
      end
    end

    def keys_including(other) = [other.keys, keys].flatten.uniq

  end
end
