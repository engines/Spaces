module Universes
  class Universe < ::Spaces::Model
    include ::Spaces::Workspace

    def path = workspace.join("#{identifier}")

    def space_map
      @space_map ||=
        space_array.inject({}) do |m, s|
          m.tap { |m| m[s.identifier] = s }
        end
    end

    def space_array
      @space_array ||=
      [
        Classifying::Space.new(identifier: :classifiers, universe_identifier: identifier),

        Publishing::Space.new(identifier: :publications, universe_identifier: identifier),
        Keys::Space.new(identifier: :user_keys, universe_identifier: identifier),
        Blueprinting::Space.new(identifier: :blueprints, universe_identifier: identifier),
        Locating::Space.new(identifier: :locations, universe_identifier: identifier),

        Providers::Space.new(identifier: :providers, universe_identifier: identifier),
        Domains::Space.new(identifier: :domains, universe_identifier: identifier),
        Arenas::Space.new(identifier: :arenas, universe_identifier: identifier),

        Resolving::Space.new(identifier: :resolutions, universe_identifier: identifier),
        Packing::Space.new(identifier: :packs, universe_identifier: identifier),
        Orchestrating::Space.new(identifier: :orchestrations, universe_identifier: identifier),

        Registry::Space.new(identifier: :registry, universe_identifier: identifier),
        Images::Space.new(identifier: :images, universe_identifier: identifier),
        Capsules::Space.new(identifier: :capsules, universe_identifier: identifier),

        ::Spaces::Commands::Space.new(identifier: :commands, universe_identifier: identifier)
      ]
    end

    def identifier = struct.identifier

    def host = 'engines.internal'

    def initialize(struct: nil, identifiable: nil)
      super(struct: struct)
      self.struct.identifier = identifiable if identifiable
    end

    def method_missing(m, *args, &block)
      space_map[m] || super
    end

    def respond_to_missing?(m, *)
      space_map[m] || super
    end

  end
end
