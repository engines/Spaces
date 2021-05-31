require_relative 'flattening'
require_relative 'packing'
require_relative 'provisioning'
require_relative 'status'

module Resolving
  class Resolution < ::Emissions::Emission
    include Resolving::Flattening
    include Resolving::Packing
    include Resolving::Provisioning
    include Resolving::Status

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:runtime_binding, :packing_binding] => :arena,
      [:resolutions, :packs, :provisioning] => :universe,
      [:arenas, :blueprints] => :resolutions
    )

    def arena; @arena ||= arenas.by(arena_identifier) ;end

    def predecessor; @predecessor ||= blueprints.by(blueprint_identifier) ;end

    alias_accessor :blueprint, :predecessor
    alias_accessor :binder, :predecessor

    def identifiers
      super.merge(
        {
          arena_identifier: arena_identifier,
          blueprint_identifier: blueprint_identifier
        }
      )
    end

    def arena_identifier; identifier.split_compound.first ;end

    def complete?
      all_complete?(divisions)
    end

    def connections_resolved
      connections_down(emission: :blueprint).map { |c| c.with_embeds.resolved_in(arena) }
    end

    def embeds_including_blueprint; [blueprint, embeds_down].flatten.compact.reverse ;end

    def content_into(directory, source:)
      resolutions.file_names_for(directory, source.context_identifier).map do |t|
        Interpolating::FileText.new(origin: t, directory: directory, transformable: self)
      end
    end

    def empty; super.tap { |m| m.arena = arena } ;end

  end
end
