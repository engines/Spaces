module Emissions
  module Resolvable

    def complete?
      texts.values.map(&:complete?).all_true?
    end

    def resolved
      @resolved ||= OpenStruct.new(resolved_texts)
    end

    def resolved_texts
      @resolved_texts ||= texts.transform_values(&:resolved)
    end

    def texts
      @texts ||= struct.to_h.transform_values { |v| text_from(v) }
    end

    def text_from(value)
      Interpolating::Text.new(origin: value, transformable: self)
    end

  end
end
