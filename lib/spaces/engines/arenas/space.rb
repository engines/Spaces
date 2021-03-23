module Arenas
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Arena
      end
    end

    def save(model)
      super.tap do
        _save(model, content: model.stanzas_content, as: payload_extension)
      end
    end

    def payload_path_for(model)
      path_for(model).join("*.#{payload_extension}")
    end

    def path_for(model)
      path.join(model.arena.context_identifier)
    end

    def payload_extension; :tf ;end
  end
end
