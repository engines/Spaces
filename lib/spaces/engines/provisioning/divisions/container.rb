require_relative 'commissioning'

module Divisions
  class Container < ::Divisions::Division
    include ProviderDependent
    include Commissioning

    alias_accessor :provisions, :emission

    delegate([:identifier, :connections_down, :connect_bindings, :images, :volumes] => :provisions)

    def provider_aspect_name_elements
      ['providers', runtime_identifier, qualifier]
    end

    def image_name
      struct.image || matching_image&.output_image
    end

    def matching_image
      images&.all&.detect { |i| i.type == runtime_identifier }
    end

  end
end
