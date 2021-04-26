module Divisions
  class Container < ::Divisions::Division

    class << self
      def prototype(emission:, label:)
        constant_for(type_for(emission)).new(emission: emission, label: label)
      end
    end

    alias_accessor :provisions, :emission

    delegate([:identifier, :connections_down, :connect_bindings, :images, :volumes] => :provisions)

    def image_name
      struct.image || matching_image&.output_image
    end

    def matching_image
      images&.all&.detect { |i| i.type == runtime_type }
    end

  end
end
