module Resolving
  module Mirroring

    def mirror_by(identifiable, klass = default_model_class)
      klass.new(identifiable: identifiable, struct: klass.from_yaml(mirror_path_for(identifiable).read))
    rescue Errno::ENOENT, NoMethodError
      raise ::Spaces::Errors::LostInSpace, {space: self.identifier, identifier: identifiable&.identifier}
    end

    def update(model)
      reset(model).tap do
        save_mirror_for(model)
      end
    end

    def reset(model)
      ensure_connections_reset_for(model)
      save_yaml(model).tap do
        ensure_mirror_for(model)
        reset_auxiliaries_for(model)
      end
    end

    def save(_)
      raise SimpleSaveDisallowed
    end

    protected

    def ensure_mirror_for(model)
      save_mirror_for(model) unless mirror_path_for(model).exist?
    end

    def save_mirror_for(model)
      mirror_path_for(model).write(model.to_yaml)
    end

    def mirror_path_for(identifiable)
      path_for(identifiable).join('mirror.yaml')
    end

  end

  class SimpleSaveDisallowed < ::Spaces::Errors::SpacesError ;end
end
