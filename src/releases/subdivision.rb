require_relative 'division'

module Releases
  class Subdivision < Division

    relation_accessor :division

    delegate([:release, :context_identifier] => :division)

    def initialize(struct:, division:)
      self.struct = struct
      self.division = division
    end

  end
end
