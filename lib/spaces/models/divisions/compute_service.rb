module Divisions
  class ComputeService < ::Divisions::Division

    def identifiers = struct&.values&.map(&:identifier)&.map(&:to_sym)

    def identifier_for(compute_identifier) =
      (struct[compute_identifier] || default)&.identifier

    def inflated = self
    def deflated = self

    def embedded_with(other)
      duplicate(itself).tap do |d|
        d.struct = other.struct.merge(d.struct)
      end
    end

    def keys_including(other) = [other.keys, keys].flatten.uniq

  end
end
