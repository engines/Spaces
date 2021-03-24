module Emissions
  module Resolving

    def resolved_in(arena)
      empty_resolution.tap do |m|
        m.predecessor = self
        m.arena = arena
        m.struct = arena.struct.without(:bindings).merge(struct)
        m.struct.identifier = "#{arena.identifier}/#{identifier}"
      end.flattened.resolved
    end

    def resolved
      empty.tap do |m|
        m.predecessor = predecessor
        m.struct = m.struct.merge(
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

  end
end
