require_relative '../spaces/descriptor'
require_relative '../releases/division'

module Clients
  class Client < ::Releases::Division

    delegate(identifier: :descriptor)

    def default
      @default ||= OpenStruct.new(descriptor: descriptor_class.new(identifier: 'any').struct)
    end

    def descriptor_class; Spaces::Descriptor ;end

  end
end
