module Arenas
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Arena
      end
    end

    delegate([:resolutions, :packs, :provisioning] => :universe)

    def dependent_spaces; [resolutions, packs, provisioning] ;end

    def save_bootstrap_resolutions_for(model)
      model.resolutions.map { |r| resolutions.save(r) }
    end

    def save_bootstrap_provisionings_for(model)
      model.provisioned.map { |p| provisioning.save(p) }
    end

    def save(model)
      super.tap do
        artifact_file_name_for(model).write(model.artifact)
      end
    end

    def save_initial(model)
      initial_file_name_for(model).write(model.initial_artifact)
    end

    def delete(model)
      super.tap do
        dependent_spaces.each { |s| s.path.join(model.identifier).rmtree }
        model.clear_resolution_map
      end
    end

    def artifact_file_name_for(model)
      path_for(model).join("_arena.#{artifact_extension}")
    end

    def initial_file_name_for(model)
      path_for(model).join("_initial.#{artifact_extension}")
    end

    def path_for(model)
      model.respond_to?(:arena) ? path.join(model.arena.context_identifier) : super
    end

    def artifact_extension; :tf ;end

  end
end
