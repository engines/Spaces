require_relative 'division'

module Emissions
  class Association < Division

    class << self
      def prototype(emission:, label:)
        new(struct: struct_for(emission, label), label: label)
      end

      def struct_for(emission, label)
        emission.struct[label] || default_struct
      end
    end

    alias_method :context_identifier, :identifier

    def initialize(struct: nil, identifier: nil, label: nil)
      self.label = label
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.identifier = identifier if identifier
    end

  end
end
