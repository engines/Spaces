module Associations
  class Tenant < ::Emissions::Division

    delegate(identifier: :descriptor)

    def default_struct
      OpenStruct.new(descriptor: descriptor_class.new(identifier: 'engines').struct)
    end

    def descriptor_class; Spaces::Descriptor ;end

  end
end
