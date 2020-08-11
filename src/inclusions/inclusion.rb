require_relative '../releases/descriptive_subdivision'

module Inclusions
  class Inclusion < ::Releases::DescriptiveSubdivision

    def memento
      [
        struct,
        resolution.memento_for(:inclusions)
      ]
    end

  end
end
