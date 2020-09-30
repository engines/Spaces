require_relative '../models/descriptor'

module Defaultables
  module Defaultable

    def identifier; descriptor.identifier ;end

    def default
      OpenStruct.new(descriptor: descriptor_class.new(identifier: 'engines').struct)
    end

    def descriptor_class; Spaces::Descriptor ;end

  end
end
