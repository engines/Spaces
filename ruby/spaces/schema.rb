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

      define_method (:outline) {{}}
      define_method (:outline_map) {{}}
      define_method (:collaborating_classes) {[]}

      define_method (:schema_class_for) { |k| collaborator_map[k]&.schema }
      define_method (:collaborator_map) { @collaborator_map ||= map_for(collaborating_classes) }

      def map_for(classes)
        classes.inject({}) do |m, k|
          m[key_for(k)] = k
          m
        end
      end

      define_method (:key_for) { |klass| mapped_key_for(klass.to_s.snakize.split('/').last.to_sym) }
      define_method (:mapped_key_for) { |key| outline_map[key] || key }
    end

    delegate([:deep_outline, :outline, :collaborator_map, :outline_map] => :klass)

    define_method (:keys) { collaborator_map.keys }

  end
end
