require_relative 'thing'

module Spaces
  class Schema < Thing

    class << self

      def deep_outline
        outline.keys.inject({}) do |m, k|
          m[k] = if (s = collaborator_map[k]&.schema)
            [outline[k], s.deep_outline]
          else
            outline[k]
          end
          m
        rescue NoMethodError
          m[k] = outline[k]
        end
      end

      def outline
        {}
      end

      def outline_map
        {}
      end

      def collaborating_classes
        []
      end

      def collaborator_map
        @collaborator_map ||= map_for(collaborating_classes)
      end

      def map_for(classes)
        classes.inject({}) do |m, k|
          m[key_for(k)] = k
          m
        end
      end

      def key_for(klass)
        mapped_key_for(klass.to_s.snakize.split('/').last.to_sym)
      end

      def mapped_key_for(key)
        outline_map[key] || key
      end
    end

    delegate([:deep_outline, :outline, :collaborator_map, :outline_map] => :klass)

    def keys
      collaborator_map.keys
    end

    # def method_missing(m, *args, &block)
    #   if keys.include?(m)
    #     collaborator_map[m.to_sym]
    #   else
    #     super
    #   end
    # end

  end
end
