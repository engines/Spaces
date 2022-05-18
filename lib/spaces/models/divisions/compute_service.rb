module Divisions
  class ComputeService < ::Divisions::Division

    def identifier_for(compute_identifier)
      (struct[compute_identifier] || default)&.identifier
    end

    def inflated; self ;end
    def deflated; self ;end

    def embedded_with(other)
      duplicate(itself).tap do |d|
        keys_including(other).each do |k|
          d.struct[k] = other.struct[k].merge(d.struct[k])
        end
      end
    end

    def keys_including(other)
      [other.keys, keys].flatten.uniq
    end

  end
end
