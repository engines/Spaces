module Provisioning
  class Provisions < ::Emissions::Emission

    relation_accessor :arena
    alias_accessor :resolution, :predecessor

    delegate(
      [:arenas, :resolutions] => :universe,
      [:has?, :divisions, :connecting_descriptors] => :resolution
    )

    def arena_identifier; arena&.identifier || identifier.split('/').first ;end
    def resolution_identifier; resolution&.identifier || identifier.split('/').last ;end

    def emit
      super.tap do |e|
        e.identifier = identifier
        e.arena_identifier = arena.identifier
        e.resolution_identifier = resolution.identifier
      end
    end

    def file_name; resolution.identifier ;end

    def stanzas
      divisions.map(&:provisioning_stanzas).flatten.compact
    end

    def initialize(struct: nil, arena: nil, resolution: nil, identifier: nil)
      super(struct: struct)
      self.struct.identifier ||= identifier
      self.arena = arena || arenas.by(arena_identifier)
      self.resolution = resolution || resolutions.by(resolution_identifier)
      self.struct.identifier ||= "#{arena.identifier}/#{resolution.identifier}"
    end

  end
end
