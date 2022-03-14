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

    def connectables_for(identifier:)
      identifiers - unconnectables_for(identifier: identifier)
    end

    def unconnectables_for(identifier:)
      [
        (i = identifier.identifier),
        connected_identifiers_for(identifier),
        tree_path_identifiers.select { |x| x.include?(i) }.map { |a| a.split(i).first }
      ].flatten.uniq
    end

    def connected_identifiers_for(identifiable)
      by(identifiable).connections.map(&:arena).map(&:tree_paths).flatten.map(&:identifiers)
    end

    def tree_path_identifiers
      all.map(&:tree_paths).flatten.map(&:identifiers)
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
