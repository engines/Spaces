require_relative 'interfacing'

module Arenas
  class Space < ::Spaces::Space
    include ::Arenas::Interfacing

    class << self
      def default_model_class
        Arena
      end
    end

    delegate([:resolutions, :packs, :provisioning] => :universe)

    alias_method :identifiers, :simple_identifiers

    def cascade_deletes; [:resolutions] ;end

    def artifacts_for(identifier, purpose)
      if (m = exist_then_by(identifier))
        interface_for(m, purpose).artifacts
      end
    end

    def save_resolutions_for(arena, force: false)
      (force ? arena.bound_resolutions : arena.unsaved_resolutions).
        tap { touch(arena) }.
        map { |r| resolutions.save(r) }
    end

    def save_artifacts_for(arena, purpose)
      ensure_space_for(arena)
      interface_for(arena, purpose)&.save_artifacts
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
