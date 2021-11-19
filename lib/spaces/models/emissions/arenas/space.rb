require_relative 'interfacing'

module Arenas
  class Space < ::Spaces::Space
    include ::Arenas::Interfacing

    class << self
      def default_model_class
        Arena
      end
    end

    delegate([:installations, :resolutions, :packs, :provisioning] => :universe)

    alias_method :identifiers, :simple_identifiers

    def cascade_deletes; [:installations] ;end

    def save_installations_for(arena, force: false)
      (force ? arena.bound_installations : arena.unsaved_installations). # NOW WHAT?
        map { |i| installations.save(i) }.
        tap { touch(arena) }
    end

    def save_resolutions_for(arena, force: false)
      (force ? arena.bound_resolutions : arena.unsaved_resolutions). # NOW WHAT?
        map { |r| resolutions.save(r) }.
        tap { touch(arena) }
    end

    def save_provisioning_artifacts_for(arena)
      ensure_space_for(arena)
      provider_interface_for(arena)&.save_artifacts # FIX!
    end

    def provider_interface_for(arena)  #TODO: refactor
      arena.provisioning_provider.interface_for(arena, self)
    end

    def path_for(model)
      model.respond_to?(:arena) ? path.join(model.arena.context_identifier) : super
    end

  end

  module Errors
    class ProvisioningError < ::Spaces::Errors::SpacesError
    end
  end
end
