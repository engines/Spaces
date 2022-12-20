module Divisions
  module Resolvable

    def resolved =
      empty.
        tap { |d| d.struct =
          resolvable_struct_class.new(struct).
            tap { |m| m.transformable = self }.resolved
        }

    def infix_qualifier = qualifier
    def resolvable_struct_class = ResolvableStruct

  end



  class ResolvableStruct < OpenStruct

    attr_accessor :transformable

    def resolved =
      JSON.parse(
        text_from(to_json).resolved,
        object_class: OpenStruct
      )

    def text_from(value) =
      Interpolating::Text.new(origin: value, transformable: transformable)

  end
end
