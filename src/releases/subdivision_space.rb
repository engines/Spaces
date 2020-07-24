require_relative '../spaces/subspace'

module Releases
  class SubdivisionSpace < Spaces::Subspace

    def by(struct:, division:)
      load(struct.type)
      loaded.detect { |k| k.qualifier == struct.type }.new(struct: struct, division: division)
    end

  end
end
