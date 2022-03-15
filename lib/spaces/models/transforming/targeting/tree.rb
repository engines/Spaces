module Targeting
  class Tree < ::Divisions::Divisible

    def complete?; all_complete?(all) ;end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def flattened
      empty.tap { |d| d.struct = all.map(&:flattened).map(&:struct) }
    end

    def descendant_paths(previous = OpenStruct.new(identifiers: [context_identifier]))
      [any? ? map { |b| b.descendant_path_with(previous) } : previous].flatten
    end

    def descriptors
      all.map(&:descriptor).compact
    end

    def emission_type; emission.qualifier ;end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
