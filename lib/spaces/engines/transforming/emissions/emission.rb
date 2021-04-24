require_relative 'content'
require_relative 'associating'
require_relative 'publishing'
require_relative 'inflating'
require_relative 'targeting'
require_relative 'topology'
require_relative 'embedding'
require_relative 'resolving'
require_relative 'hashing'

module Emissions
  class Emission < ::Transforming::Transformable
    include ::Divisions::Dividing
    include Content
    include Associating
    include Publishing
    include Inflating
    include Targeting
    include Topology
    include Embedding
    include Resolving
    include Hashing

    class << self
      def composition; @composition ||= composition_class.new ;end
      def composition_class; Composition ;end
    end

    relation_accessor :predecessor
    relation_accessor :arena

    delegate(
      composition: :klass,
      associations_and_divisions: :composition
    )

    alias_method :emission, :itself

    def has?(property); struct[property] ;end

    def runtime_type
      arena&.runtime_type
    end

    def container_type
      arena&.container_type
    end

    def count
      has?(:scaling) ? scaling.count : 1
    end

    def empty; klass.new(identifier: identifier) ;end

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

  end
end
