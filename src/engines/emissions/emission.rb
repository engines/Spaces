require_relative 'transformable'
require_relative 'embedding'
require_relative 'resolving'

module Emissions
  class Emission < Transformable
    include Embedding
    include Resolving

    class << self
      def composition; @composition ||= composition_class.new ;end
      def composition_class; Composition ;end
    end

    relation_accessor :predecessor

    delegate(composition: :klass)

    alias_method :emission, :itself
    alias_method :has?, :respond_to?

    def turtles; turtle_targets.map(&:blueprint) ;end
    def turtle_targets; targets(:turtle_targets) ;end

    def targets(type); has?(:bindings) ? bindings.send(type) : [] ;end

    def incomplete_divisions
      divisions.reject(&:complete?)
    end

    def mandatory_divisions_present?
      division_keys & mandatory_keys == mandatory_keys
    end

    def stanzas_content
      stanzas.join("\n")
    end

    def stanzas
      divisions.map(&:stanzas)
    end

    def divisions; division_map.values ;end

    def count
      has?(:scaling) ? scaling.count : 1
    end

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m.tap do
          m[k] = division_for(k)
        end
      end.compact
    end

    def composition_keys; composition.keys ;end
    def division_keys; division_map.keys ;end

    def division_for(key)
      composition.divisions[key]&.prototype(emission: self, label: key)
    end

    def empty; klass.new(identifier: identifier) ;end

    def initialize(struct: nil, identifier: nil)
      super(struct: struct)
      self.struct.identifier = identifier if identifier
    end

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
