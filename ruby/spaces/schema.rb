require_relative 'thing'
require_relative 'descriptor'

module Spaces
  class Schema < Thing

    class << self
      def deep_outline
        outline.keys.inject({}) do |m, k|
          m[k] = if (s = schema_class_for(k))
            [outline[k], s.deep_outline]
          else
            outline[k]
          end
          m
        rescue NoMethodError
          m[k] = outline[k]
        end
      end

      def outline; {} ;end
      def naming_map; {} ;end
      def collaborating_classes; [] ;end

      def schema_class_for(key); collaborating_classes_map[key]&.schema ;end
      def collaborating_classes_map; @collaborating_classes_map ||= map_for(collaborating_classes) ;end

      def map_for(classes)
        classes.inject({}) do |m, k|
          m[key_for(k)] = k
          m
        end
      end

      def key_for(klass); mapped_key_for(klass.to_s.snakize.split('/').last.to_sym) ;end
      def mapped_key_for(key); naming_map[key] || key ;end
    end

    delegate([:deep_outline, :outline, :collaborating_classes_map, :naming_map] => :klass)

    def keys; collaborating_classes_map.keys ;end

  end
end
