module Resolving
  module Resolving

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

  end
end
