require_relative '../spaces/subspace'

module Releases
  class DivisionSpace < Spaces::Subspace

    def by(collaboration)
      t = collaboration.struct[super_qualifier].type
      load(t)
      loaded.detect { |k| k.type == t }.new(collaboration: collaboration, label: super_qualifier)
    end

    def super_qualifier
      default_model_class.qualifier
    end

  end
end
