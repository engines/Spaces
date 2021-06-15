require_relative 'terraforming'

module Arenas
  class Space < ::Spaces::Space
    include ::Arenas::Terraforming

    class << self
      def default_model_class
        Arena
      end
    end

    delegate([:installations, :resolutions, :packs, :provisioning] => :universe)

    alias_method :identifiers, :simple_identifiers

    def dependent_spaces; [resolutions, packs, provisioning] ;end

    def save_installations_for(arena)
      arena.unsaved_installations.map { |i| installations.save(i) }
    end

    def save_resolutions_for(arena)
      arena.unsaved_resolutions.map { |r| resolutions.save(r) }
    end

    def save_initial(arena)
      initial_file_name_for(arena).write(arena.initial_artifacts)
      arena.identifier
    end

    def save_runtime(arena)
      runtime_file_name_for(arena).write(arena.runtime_artifacts)
      arena.identifier
    end

    def save_other_providers(arena)
      arena.tap do |m|
        m.other_providers.each do |p|
          provider_file_name_for(p).write(p.provider_artifacts)
        end
      end.identifier
    end

    def delete(identifiable)
      super.tap do
        dependent_spaces.each do |s|
          if (p = s.path.join(identifiable.identifier)).exist?
            p.rmtree
          end
        end
      end
    end

    def initial_file_name_for(arena)
      path_for(arena).join("_initial.#{artifact_extension}")
    end

    def runtime_file_name_for(arena)
      path_for(arena).join("_runtime.#{artifact_extension}")
    end

    def provider_file_name_for(provider)
      path_for(provider.arena).join("_#{provider.qualifier}.#{artifact_extension}")
    end

    def path_for(model)
      model.respond_to?(:arena) ? path.join(model.arena.context_identifier) : super
    end

    def artifact_extension; :tf ;end

  end

  module Errors
    class ProvisioningError < ::Spaces::Errors::SpacesError
    end
  end
end
