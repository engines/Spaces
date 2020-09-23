require_relative '../emissions/divisible'

module Divisions
  class Configuration < ::Emissions::Division

        def emit; resolved ;end

        def resolved
          @resolved ||= OpenStruct.new(texts.transform_values(&:resolved))
        end

        def texts
          struct.to_h.transform_values { |v| text_from(v) }
        end

        def text_from(value)
          interpolating_class.new(origin: value, division: self)
        end

        def interpolating_class; Interpolating::Text ;end

  end
end
