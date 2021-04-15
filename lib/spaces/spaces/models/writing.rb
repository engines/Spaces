module Spaces
  module Writing
    include Engines::Logger

    def save_yaml(model)
      _save(model, content: model.to_yaml, as: :yaml)
    end

    alias_method :save, :save_yaml

    def save_text(model)
      _save(model, content: model.content).tap do
        set_permission_for(model) if model.respond_to?(:permission)
      end
    end

    def save_json(model)
      _save(model, content: model.to_json, as: :json)
    end

    def _save(model, content:, as: nil)
      model.tap do |m|
        Pathname.new([writing_name_for(m), as].compact.join('.')).write(content)
      end
      model.identifier
    end

    def delete(model)
      writing_path_for(model).rmtree
      model.identifier
    end

    def writing_name_for(model)
      ensure_space_for(model)
      "#{writing_path_for(model)}/#{model.file_name}"
    end

    def ensure_space_for(identifiable)
      writing_path_for(identifiable).mkpath
    end

    def writing_path_for(identifiable)
      path.join(identifiable.context_identifier.as_path, identifiable.subpath)
    end

    protected

    # FIXME: the permissions should be passed in
    def set_permission_for(model)
      writing_name_for(model).tap do |n|
        Pathname.new(n).chmod(model.permission)
        logger.debug("Saving #{n} with permissions [#{sprintf "%o", model.permission}]")
      end
    end

  end
end
