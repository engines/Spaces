require_relative 'transformable'
require_relative 'auxiliaries'
require_relative 'dividing'
require_relative 'associating'
require_relative 'inflating'
require_relative 'targeting'
require_relative 'embedding'
require_relative 'resolving'
require_relative 'hashing'

module Emissions
  class Emission < Transformable
    include Auxiliaries
    include Dividing
    include Associating
    include Inflating
    include Targeting
    include Embedding
    include Resolving
    include Hashing

    class << self
      def composition; @composition ||= composition_class.new ;end
      def composition_class; Composition ;end
    end

    relation_accessor :predecessor

    delegate(composition: :klass)

    alias_method :emission, :itself
    alias_method :has?, :respond_to?

    def count
      has?(:scaling) ? scaling.count : 1
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
