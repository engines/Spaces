require_relative 'transformable'

module Emissions
  class Emission < Transformable

    class << self
      def composition = @composition ||= composition_class.new
      def composition_class = Composition
    end

    relation_accessor :predecessor

    delegate(composition: :klass)

    alias_method :emission, :itself
    alias_method :has?, :respond_to?

    def turtle_descriptors
      bindings.turtles.map(&:descriptor).uniq(&:identifier) if has?(:bindings)
    end

    def emit
      OpenStruct.new(to_h).tap { |e| e.identifier = struct.identifier }
    end

    def incomplete_divisions = divisions.reject(&:complete?)

    def mandatory_divisions_present?
      division_keys & mandatory_keys == mandatory_keys
    end

    def stanzas_content = stanzas.join("\n")

    def stanzas = divisions.map(&:stanzas)

    def divisions = division_map.values

    def count = has?(:scaling) ? scaling.count : 1

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m.tap do
          m[k] = division_for(k)
        end
      end.compact
    end

    def to_h
      division_keys.inject({}) do |m, k|
        m.tap { m[k] = emit_for(k) }
      end.compact
    end

    def composition_keys = composition.keys
    def division_keys = division_map.keys

    def division_for(key)
      composition.divisions[key]&.prototype(emission: self, label: key)
    end

    def emit_for(key) = division_map[key]&.emit || struct[key]

    def descriptors_for(division_identifier)
      descriptors_structs_for(division_identifier).map { |d| descriptor_class.new(d) }.uniq(&:uniqueness)
    end

    def descriptors_structs_for(division_identifier)
      (struct[division_identifier] || []).map { |d| d[:descriptor] }.compact
    end

    def maybe_with_embeds_in(division) = division
    def embeds = []

    def method_missing(m, *args, &block)
      return division_map[m.to_sym] || struct[m] if division_keys.include?(m)
      return bindings.named(m) if (struct[:bindings] && bindings.named(m))
      super
    end

    def respond_to_missing?(m, *)
      division_keys.include?(m) || (struct[:bindings] && emission.bindings.named(m)) || super
    end

  end
end
