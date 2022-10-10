module Settling
  class Space < ::Emissions::Space

    delegate([:blueprints, :arenas] => :universe)

    def by(settlement, klass = default_model_class)
      super.tap do |m|
        m.arena = arenas.by(m.arena_identifier)
      end
    end

    def summaries(arena_identifier:) =
      all(arena_identifier: arena_identifier).map(&:summary)

    def all(arena_identifier:)
      identifiers(arena_identifier: arena_identifier).map do |i|
        exist_then_by(i)
      end.compact
    end

    def identifiers(arena_identifier: '*', application_identifier: '*')
      path.glob("#{arena_identifier}/#{application_identifier}").map do |p|
        "#{p.relative_path_from(path)}".as_compound
      end
    end

  end
end
