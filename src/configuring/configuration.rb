require_relative '../emitting/emissions/divisible'

module Configuring
  class Configuration < ::Emitting::Division

        def emit; resolved ;end

        def resolved
          @resolved ||= OpenStruct.new(texts.transform_values(&:resolved))
        end

        def texts
          struct.to_h.transform_values { |v| text_from(v) }
        end

        def text_from(value)
          text_class.new(origin: value, division: self)
        end

        def text_class; Texts::Text ;end

  end
end
