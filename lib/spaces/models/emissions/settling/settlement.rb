module Settling
  class Settlement < ::Arenas::Emission
    include Embedding
    include Infixing

    delegate([:blueprints, :resolutions] => :universe)

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

    def domain
      domains.first
    end

    def connections_down(emission: :resolution)
      connect_bindings.map { |t|
        arena.send("#{emission}_map")[t.identifier]
      }.compact
    end

    def content_into(directory, source:)
      resolutions.file_names_for(directory, source.context_identifier).map do |t|
        Interpolating::FileText.new(origin: t, directory: directory, transformable: self)
      end
    end

  end
end
