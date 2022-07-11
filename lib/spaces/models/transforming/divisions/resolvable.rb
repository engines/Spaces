module Divisions
  module Resolvable

    def resolved =
      empty.
        tap { |d| d.struct = resolvable_struct_class.new(struct, self).resolved }

    def flattened =
      empty.tap { |d| d.struct = flattened_struct }

    def flattened_struct = unresolved_struct.merge(struct)

    def unresolved_struct
      OpenStruct.new(
        unresolved_variables.inject({}) do |m, k|
          m.tap { m[k] = nil }
        end
      )
    end

    def unresolved_variables =
      emission.unresolved_infixes[infix_qualifier] || []

    def infix_qualifier = qualifier
    def resolvable_struct_class = ResolvableStruct

  end



  class ResolvableStruct < OpenStruct

    attr_accessor :transformable

    def resolved =
      OpenStruct.new(texts.transform_values(&:resolved))

    def texts =
      to_h.transform_values { |v| text_from(v) }

    def text_from(value) =
      Interpolating::Text.new(origin: value, transformable: transformable)

    def initialize(struct, transformable)
      super(struct)
      self.transformable = transformable
    end

  end
end
