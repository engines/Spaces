module Emissions
  class Space < ::Spaces::Space

    delegate(resolutions: :universe)

    def anchor_resolutions_for(resolution)
      unique_anchor_resolutions_for(resolution).map { |d| resolutions.by(d.identifier) }
    end

    def unique_anchor_resolutions_for(resolution)
      resolution.binding_descriptors&.uniq(&:uniqueness) || []
    end

  end
end
