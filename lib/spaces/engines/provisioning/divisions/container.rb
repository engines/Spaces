require_relative 'commissioning'

module Divisions
  class Container < ::Divisions::Division
    include RuntimeDefining
    include Commissioning

    alias_accessor :provisions, :emission

    delegate([:identifier, :connections_down, :connect_bindings, :runtime_image, :volumes] => :provisions)

    def image_name
      struct.image || runtime_image&.output_name
    end

  end
end
