module Arenas
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Arena
      end
    end

    def save(model)
      super.tap do
        _save(model, content: model.stanzas_content, as: :tf)
      end
    end

    def path_for(model)
      path.join(model.arena.context_identifier)
    end
  end
end
