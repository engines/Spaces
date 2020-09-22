require_relative 'thing'
require_relative 'descriptor'

module Spaces
  class Composition < Thing

    class << self
      def naming_map; {} ;end
      def division_classes; [] ;end

      def composition_class_for(key); divisions[key]&.composition ;end
      def divisions; @divisions ||= map_for(division_classes) ;end

      def map_for(classes)
        classes.inject({}) do |m, k|
          m.tap { m[key_for(k)] = k }
        end
      end

      def key_for(klass); mapped_key_for(klass.qualifier.to_sym) ;end
      def mapped_key_for(key); naming_map[key] || key ;end
    end

    delegate([:divisions, :naming_map] => :klass)

    def keys; divisions.keys ;end

  end
end
