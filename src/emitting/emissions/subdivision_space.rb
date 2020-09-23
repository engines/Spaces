module Emissions
  class SubdivisionSpace < Spaces::Subspace

    def by(struct:, division:)
      loaded.detect { |k| k.qualifier == struct.type }.new(struct: struct, division: division)
    end

  end
end
