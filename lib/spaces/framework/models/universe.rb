require_relative 'model'

module Spaces
  class Universe < Model

    class << self
      def space_map
        @@space_map ||=
          space_array.inject({}) do |m, s|
            m.tap { |m| m[s.identifier] = s }
          end
      end

      def space_array
        @@space_array ||=
        [
          Publishing::Space.new(identifier: :publications),
          Keys::Space.new(identifier: :user_keys),
          Blueprinting::Space.new(identifier: :blueprints),
          Locating::Space.new(identifier: :locations),

          Providers::Space.new(identifier: :providers),
          Domains::Space.new(identifier: :domains),
          Arenas::Space.new(identifier: :arenas),

          Resolving::Space.new(identifier: :resolutions),
          Packing::Space.new(identifier: :packs),
          Orchestrating::Space.new(identifier: :orchestrations),

          Registry::Space.new(identifier: :registry),
          Images::Space.new(identifier: :images),
          Capsules::Space.new(identifier: :capsules)
        ]
      end
    end

    def identifier; struct.identifier ;end

    def host; 'engines.internal' ;end

    def initialize(struct: nil, identifiable: nil)
      super(struct: struct)
      self.struct.identifier = identifiable.identifier if identifiable
    end

    def method_missing(m, *args, &block)
      klass.space_map[m] || super
    end

    def respond_to_missing?(m, *)
      klass.space_map[m] || super
    end

  end
end
