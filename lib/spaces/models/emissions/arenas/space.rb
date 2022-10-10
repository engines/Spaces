require_relative 'interfacing'

module Arenas
  class Space < ::Targeting::TreeSpace
    include Interfacing

    alias_method :connectables_for, :new_leaves_for

    class << self
      def default_model_class = Arena
    end

    delegate([:resolutions, :packs, :orchestrations] => :universe)

    def cascade_deletes = [:resolutions]

    def save_resolutions_for(arena, force: false)
      (force ? arena.bound_resolutions : arena.unsaved_resolutions).
        tap { touch(arena) }.
        map { |r| resolutions.save(r) }
    end

    def copy_artifacts_for(orchestration)
      d = path_for(orchestration.arena)
      orchestrations.path_for(orchestration).tap do |s|
        FileUtils.cp_r(s.children, d) if s.exist?
      end
    end

    def remove_artifacts_for(orchestration)
      d = path_for(orchestration.arena)
      orchestrations.path_for(orchestration).tap do |s|
        s.children.map do |c|
          p = d.join(c.basename)
          p.delete if p.exist?
        end
      end
    end

    def unrepeatable_children_for(identifiable) =
      by(identifiable).connections.map(&:arena).map(&:descendant_paths).flatten.map(&:identifiers)

    def path_for(model) =
      model.respond_to?(:arena) ? path.join(model.arena.context_identifier) : super

  end

  module Errors
    class OrchestratingError < ::Spaces::Errors::SpacesError
    end
  end
end
