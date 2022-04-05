require_relative 'interfacing'

module Arenas
  class Space < ::Targeting::TreeSpace
    include Interfacing

    alias_method :connectables_for, :new_leaves_for

    class << self
      def default_model_class
        Arena
      end
    end

    delegate([:resolutions, :packs, :orchestrations] => :universe)

    def cascade_deletes; [:resolutions] ;end

    def save_resolutions_for(arena, force: false)
      (force ? arena.bound_resolutions : arena.unsaved_resolutions).
        tap { touch(arena) }.
        map { |r| resolutions.save(r) }
    end

    def unrepeatable_children_for(identifiable)
      by(identifiable).connections.map(&:arena).map(&:descendant_paths).flatten.map(&:identifiers)
    end

    def path_for(model)
      model.respond_to?(:arena) ? path.join(model.arena.context_identifier) : super
    end

    protected

    def copy_auxiliaries_for(arena)
      arena.all_packs.each do |p|
        packs.copy_auxiliaries_for(p)
      end
    end

    def remove_auxiliaries_for(arena)
      arena.all_packs.each do |p|
        packs.remove_auxiliaries_for(p)
      end
    end

  end

  module Errors
    class OrchestratingError < ::Spaces::Errors::SpacesError
    end
  end
end
