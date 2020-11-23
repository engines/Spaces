module Emissions
  module Resolvable

    def emit; resolved ;end

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

    def random(length); SecureRandom.hex(length.to_i) ;end

    def text_from(value)
      interpolating_class.new(origin: value, transformable: self)
    end

    def interpolating_class; Interpolating::Text ;end

  end
end
