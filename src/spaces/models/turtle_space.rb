module Spaces
  class TurtleSpace < Space

    delegate(resolutions: :universe)

    def anchor_resolutions_for(resolution)
      unique_anchor_resolutions_for(resolution).map { |d| resolutions.by(d) }
    end

    def unique_anchor_resolutions_for(resolution)
      resolution.binding_descriptors&.uniq(&:uniqueness) || []
    end

  end
end
