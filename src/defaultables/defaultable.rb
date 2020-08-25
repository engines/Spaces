require_relative '../spaces/descriptor'
require_relative '../releases/component'

module Defaultables
  class Defaultable < ::Releases::Component

    delegate(identifier: :descriptor)

    def default
      OpenStruct.new(descriptor: descriptor_class.new(identifier: 'engines').struct)
    end

    def descriptor_class; Spaces::Descriptor ;end

  end
end
