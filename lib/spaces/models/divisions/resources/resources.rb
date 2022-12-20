module Divisions
  class Resources < ::Divisions::Divisible

    def for_type(type) = select { |r| r.type.to_sym == type.to_sym }

    def type_identifiers = all.map(&:type_identifier)

    #TODO: consider this deep merging strategy for other Divisibles
    def struct_merged_with(other)
      u = union_with(other)
      keys_union_with(other).inject([]) do |m, k|
        [
          m,
          u.select { |r| r.type_identifier == k }.reduce({}) do |n, r|
            r.struct.deep_to_h.deep_merge(n)
          end
        ].flatten.map(&:deep_to_struct)
      end
    end

    def union_with(other) = [all, other.all].flatten

    def keys_union_with(other) =
      [type_identifiers, other.type_identifiers].flatten.uniq

  end
end
