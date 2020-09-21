require_relative '../../spaces/models/subspace'

module Emitting
  class DivisionSpace < Spaces::Subspace

    def by(division)
      t = division.struct[super_qualifier].type
      load(t)
      loaded.detect { |k| k.type == t }.new(division: division, label: super_qualifier)
    end

    def super_qualifier
      default_model_class.qualifier
    end

  end
end
