module Divisions
  class Container < ::Divisions::Subdivision

    class << self
      def constant_for(type)
        Module.const_get("::Providers::#{type.to_s.camelize}::Container")
      end
    end

    alias_accessor :resolution, :emission

    delegate([:identifier, :connections, :connect_targets] => :emission)

    def complete?
      !(type && image_name).nil?
    end

    def image_name
      struct.image || matching_image&.output_image
    end

    def matching_image
      emission.images.all.detect { |i| i.type == type }
    end

  end
end
