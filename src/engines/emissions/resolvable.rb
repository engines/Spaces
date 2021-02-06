module Emissions
  module Resolvable

    def resolved
      empty.tap { |d| d.struct = ResolvableStruct.new(struct, self).resolved }
    end

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
