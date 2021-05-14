module Emissions
  module Resolving

    def resolved_in(arena)
      empty_resolution.tap do |m|
        m.arena = arena
        m.struct = arena.struct.without(:bindings).merge(struct)
        m.cache_resolution_identifiers(arena.identifier, identifier)
      end.flattened.resolved
    end

    def resolved
      empty.tap do |m|
        m.struct = struct.merge(
          OpenStruct.new(division_map.transform_values { |v| v.resolved.struct } )
        )
      end
    end

    def unresolved_infixes
      @unresolved_infixes ||= unresolved_infix_strings.inject({}) do |m, i|
        m.tap do
          i.split('.').tap do |s|
            m[s.first] = [m[s.first], s[1]].flatten.compact.uniq
          end
        end
      end
    end

    def unresolved_infix_strings
      content.map(&:infixes).flatten.map(&:value).uniq
    end

    def empty_resolution; resolution_class.new ;end
    def resolution_class; ::Resolving::Resolution ;end

    protected

    def cache_resolution_identifiers(arena_identifier, blueprint_identifier)
      struct.identifier = "#{arena_identifier.with_identifier_separator}#{blueprint_identifier}"
      struct.arena_identifier = arena_identifier
      struct.blueprint_identifier = blueprint_identifier
    end

  end
end
