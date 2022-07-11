module Targeting
  class Tree < ::Divisions::Divisible

    def complete? = all_complete?(all)

    def named(name) = all.detect { |b| b.identifier == name.to_s }

    def flattened = empty.tap { |d| d.struct = all.map(&:flattened).map(&:struct) }

    def descendant_paths(previous = OpenStruct.new(identifiers: [context_identifier])) =
      [any? ? map { |b| b.descendant_path_with(previous) } : previous].flatten

    def descriptors = all.map(&:descriptor).compact

    def emission_type = emission.qualifier

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
