require_relative 'thing'
require_relative 'descriptor'

module Spaces
  class Schema < Thing

    class << self
      def deep_outline
        outline.keys.inject({}) do |m, k|
          m.tap do
            m[k] = if (s = schema_class_for(k))
              [outline[k], s.deep_outline]
            else
              outline[k]
            end
          end
        rescue NoMethodError => e
          warn(error: e, key: k, outline: outline[k])
          m[k] = outline[k]
        end
      end

      def naming_map; {} ;end
      def division_classes; [] ;end

      def schema_class_for(key); divisions[key]&.schema ;end
      def divisions; @divisions ||= map_for(division_classes) ;end

      def map_for(classes)
        classes.inject({}) do |m, k|
          m.tap { m[key_for(k)] = k }
        end
      end

      def key_for(klass); mapped_key_for(klass.qualifier.to_sym) ;end
      def mapped_key_for(key); naming_map[key] || key ;end
    end

    delegate([:deep_outline, :outline, :divisions, :naming_map] => :klass)

    def keys; divisions.keys ;end

  end
end
