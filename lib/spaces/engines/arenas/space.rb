#TODO: remove hard-coded Terraform hacks
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

    def cascade_deletes; [:installations] ;end

    def save_installations_for(arena, force: false)
      (force ? arena.bound_installations : arena.unsaved_installations).
        map { |i| installations.save(i) }.
        tap { touch(arena) }
    end

    def save_resolutions_for(arena, force: false)
      (force ? arena.bound_resolutions : arena.unsaved_resolutions).
        map { |r| resolutions.save(r) }.
        tap { touch(arena) }
    end

    # --------------------------------------------------------------------------
    # TODO: possibly all changes with providers being assumed and terraform
    # is not hard-wired in

    def save_initial(arena)
      initial_file_name_for(arena).write(arena.provider_aspect.initial_artifact)
      arena.identifier
    end

    def save_runtime(arena)
      runtime_file_name_for(arena).write(arena.provider_aspect.runtime_artifact)
      arena.identifier
    end

    def save_subordinate_providers(arena)
      arena.tap do |m|
        provider_interface_for(m, self).other_aspects.each do |a|
          provider_file_name_for(a).write(a.provider_artifact)
        end
        touch(arena)
      end.identifier
    end

    def initial_file_name_for(arena)
      path_for(arena).join(initial_basename)
    end

    def runtime_file_name_for(arena)
      path_for(arena).join(runtime_basename)
    end

    def provider_file_name_for(provider)
      path_for(provider.arena).join(provider_basename_for(provider))
    end

    # --------------------------------------------------------------------------

    def path_for(model)
      model.respond_to?(:arena) ? path.join(model.arena.context_identifier) : super
    end

    def initial_basename; "_initial.#{artifact_extension}" ;end
    def runtime_basename; "_runtime.#{artifact_extension}" ;end
    def provider_basename_for(provider); "_#{provider.type}.#{artifact_extension}" ;end
    def artifact_extension; :tf ;end

    def initialized_at(arena); initial_file_name_for(arena).exist_then(&:mtime) ;end
    # def bootstrapped_at(arena); runtime_file_name_for(arena).exist_then(&:mtime) ;end

  end

  module Errors
    class ProvisioningError < ::Spaces::Errors::SpacesError
    end
  end
end
