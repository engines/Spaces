module Arenas
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Arena
      end
    end

    delegate([:resolutions, :provisioning] => :universe)

    def save_bootstrap_resolutions_for(model)
      model.resolutions.map { |r| resolutions.save(r) }
    end

    def save_bootstrap_provisionings_for(model)
      model.provisioned.map { |p| provisioning.save(p) }
    end

    def save(model)
      super.tap do
        _save(model, content: model.payload, as: payload_extension)
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
