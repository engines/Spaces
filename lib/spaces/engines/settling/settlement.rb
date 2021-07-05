require_relative 'embedding'
require_relative 'infixing'

module Settling
  class Settlement < ::Emissions::Emission
    include Embedding
    include Infixing

    delegate(
      resolutions: :universe,
      [:arenas, :blueprints] => :resolutions
    )

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

    def connections_settled(&block)
      connections_down(emission: :blueprint).map { |c| block.call(c) }
    end

    def content_into(directory, source:)
      resolutions.file_names_for(directory, source.context_identifier).map do |t|
        Interpolating::FileText.new(origin: t, directory: directory, transformable: self)
      end
    end

    def empty; super.tap { |m| m.arena = arena } ;end

    def cache_primary_identifiers
      struct.identifier = "#{arena.identifier.with_identifier_separator}#{blueprint_identifier}"
      struct.arena_identifier = arena.identifier
      struct.blueprint_identifier = blueprint_identifier
    end

  end
end
