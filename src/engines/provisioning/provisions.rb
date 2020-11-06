module Provisioning
  class Provisions < ::Emissions::Emission

    relation_accessor :arena
    alias_accessor :resolution, :predecessor

    delegate(
      [:arenas, :resolutions] => :universe,
      [:divisions, :binding_descriptors] => :resolution
    )

    def identifier; "#{arena.identifier}/#{resolution.identifier}" ;end

    def emit
      super.tap do |m|
        m.identifier = identifier
        m.arena_identifier = arena.identifier
        m.resolution_identifier = resolution.identifier
      end
    end

    def stanzas
      divisions.map(&:provisioning_stanzas).flatten.compact
    end

    def initialize(struct: nil, arena: nil, resolution: nil, identifier: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.arena = arena || arenas.by(arena_identifier)
      self.resolution = resolution || resolutions.by(resolution_identifier)
      self.struct.identifier ||= identifier || self.identifier
    end

  end
end
