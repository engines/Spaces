module Universes
  class Multiverse < ::Spaces::Thing
    include ::Spaces::Workspace

    def path = workspace

    def universe_map
      @universe_map ||=
        universe_array.inject({}) do |m, s|
          m.tap { |m| m[s.identifier] = s }
        end
    end

    def universe_array
      @universe_array ||=
      [
        universe_class.new(identifiable: :universe),
        universe_class.new(identifiable: :cache)
      ]
    end

    def universe_class = Universe

    def method_missing(m, *args, &block)
      universe_map[m] || super
    end

    def respond_to_missing?(m, *)
      universe_map[m] || super
    end

  end
end
