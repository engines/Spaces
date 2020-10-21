module Emissions
  class Association < ::Emissions::Division

    alias_method :context_identifier, :identifier

    def initialize(struct: nil, identifier: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.identifier = identifier if identifier
    end

  end
end
