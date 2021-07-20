require_relative 'content'
require_relative 'associating'
require_relative 'binding'
require_relative 'topology'
require_relative 'merging'
require_relative 'hashing'

module Emissions
  class Emission < ::Transforming::Transformable
    include ::Divisions::Dividing
    include Content
    include Associating
    include Binding
    include Topology
    include Merging
    include Hashing

    class << self
      def composition; @composition ||= composition_class.new ;end
      def composition_class; Composition ;end
    end

    relation_accessor :predecessor

    delegate(
      composition: :klass,
      associations_and_divisions: :composition
    )

    alias_method :emission, :itself

    def has?(property); struct[property] ;end

    def runtime_image
      images&.all&.detect { |i| i.type == runtime_identifier }
    end

    def count
      has?(:scaling) ? scaling.count : 1
    end

    def empty; klass.new(identifiable: identifier) ;end

    def in_blueprint?; ;end

    def initialize(struct: nil, identifiable: nil)
      super(struct: struct)
      self.struct.identifier = identifiable.identifier if identifiable
    end

    def method_missing(m, *args, &block)
      return division_map[m.to_sym] || struct[m] if division_keys.include?(m)
      return bindings.named(m) if (struct[:bindings] && bindings.named(m))
      super
    end

    def respond_to_missing?(m, *)
      division_keys.include?(m) || (struct[:bindings] && emission.bindings.named(m)) || super
    end

    def cache_primary_identifiers
      # struct.identifier = "#{arena.identifier.with_identifier_separator}#{blueprint_identifier}"
      struct.arena_identifier = arena.identifier
      struct.blueprint_identifier = blueprint_identifier
    end

  end
end
