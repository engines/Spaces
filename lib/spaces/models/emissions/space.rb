module Emissions
  class Space < ::Spaces::Space

    def identifiers(arena_identifier: '*', blueprint_identifier: '*')
      path.glob("#{arena_identifier}/#{blueprint_identifier}").map do |p|
        "#{p.relative_path_from(path)}".as_compound
      end
    end

  end
end
