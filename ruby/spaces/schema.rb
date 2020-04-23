require_relative 'thing'

module Spaces
  class Schema < Thing

    class << self
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

    delegate([:outline, :outline_map, :collaborator_map] => :klass)

  end
end
