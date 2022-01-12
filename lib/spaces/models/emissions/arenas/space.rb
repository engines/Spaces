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

    def artifacts_for(identifier, purpose)
      if (m = exist_then_by(identifier))
        interface_for(m, purpose).artifacts
      end
    end

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

    def save_artifacts_for(arena, purpose)
      ensure_space_for(arena)
      interface_for(arena, purpose)&.save_artifacts
    end

    def interface_for(arena, purpose) #TODO: refactor
      arena.provisioning_provider.interface_for(arena, purpose: purpose, space: self)
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
