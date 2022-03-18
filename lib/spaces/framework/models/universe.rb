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
          Publishing::Space.new(:publications),
          Locating::Space.new(:locations),
          Blueprinting::Space.new(:blueprints),
          Resolving::Space.new(:resolutions),
          Registry::Space.new(:registry),
          Packing::Space.new(:packs),
          Provisioning::Space.new(:provisioning),
          Runtime::Space.new(:runtimes),
          Arenas::Space.new(:arenas),
          Keys::Space.new(:user_keys),

          Domains::Space.new(:domains)
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
