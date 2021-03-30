module Arenas
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Arena
      end
    end

    def save(model)
      super.tap do
        _save(model, content: model.artifact, as: artifact_extension)
      end
    end

    def artifact_path_for(model)
      path_for(model).join("*.#{artifact_extension}")
    end

    def path_for(model)
      path.join(model.arena.context_identifier)
    end

    def artifact_extension; :tf ;end
  end
end
