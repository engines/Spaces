module Spaces
  class TurtleSpace < Space

    def save(model)
      anchor_for(model)
      super
    end

    def anchor_for(model)
      unique_anchors_for(model).map { |d| by(d) }
    end

    def unique_anchors_for(model)
      model.binding_descriptors&.uniq(&:uniqueness) || []
    end

  end
end
