module Divisions
  module Resolvable

    def resolved
      empty.tap { |d| d.struct = ResolvableStruct.new(struct, self).resolved }
    end

    def flattened
      empty.tap { |d| d.struct = flattened_struct }
    end

    def flattened_struct
      unresolved_struct.merge(struct)
    end

    def unresolved_struct
      OpenStruct.new(
        unresolved_variables.inject({}) do |m, k|
          m.tap { m[k] = nil }
        end
      )
    end

    def unresolved_variables
      emission.unresolved_infixes[infix_qualifier] || []
    end

    def infix_qualifier; qualifier ;end

  end


  class ResolvableStruct < OpenStruct

    attr_accessor :transformable

    def resolved
      OpenStruct.new(texts.transform_values(&:resolved))
    end

    def texts
      to_h.transform_values { |v| text_from(v) }
    end

    def text_from(value)
      Interpolating::Text.new(origin: value, transformable: transformable)
    end

    def initialize(struct, transformable)
      super(struct)
      self.transformable = transformable
    end

  end
end
