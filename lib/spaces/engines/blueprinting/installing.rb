module Blueprinting
  module Installing

    def installation_in(arena)
      empty_installation.tap do |m|
        m.arena = arena
        m.struct.input = struct.input
        m.cache_primary_identifiers(arena.identifier, identifier)
      end
    end

    def empty_installation; installation_class.new ;end
    def installation_class; ::Installing::Installation ;end

  end
end
