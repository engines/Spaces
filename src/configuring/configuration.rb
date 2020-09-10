require_relative '../releases/component'

module Configuring
  class Configuration < ::Releases::Component

        def memento; resolved ;end

        def resolved
          @resolved ||= OpenStruct.new(texts.transform_values(&:resolved))
        end

        def texts
          struct.to_h.transform_values { |v| text_from(v) }
        end

        def text_from(value)
          text_class.new(origin: value, context: self)
        end

        def text_class; Texts::Text ;end

  end
end
