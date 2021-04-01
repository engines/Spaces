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
        _save(model, content: model.artifact, as: artifact_extension)
      end
    end

    def save_initial(model)
      initial_file_name_for(model).write(model.initial_artifact)
    end

    def initial_file_name_for(model)
      path_for(model).join("#{initial_subspace_name}/#{initial_subspace_name}.#{artifact_extension}")
    end

    def initial_subspace_name; 'initial' ;end

    def path_for(model)
      path.join(model.arena.context_identifier)
    end

    def artifact_extension; :tf ;end

    def ensure_space_for(identifiable)
      writing_path_for(identifiable).join(initial_subspace_name).mkpath
    end

  end
end
