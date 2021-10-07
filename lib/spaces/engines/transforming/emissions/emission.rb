require_relative 'content'
require_relative 'topology'
require_relative 'requires'

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

    def has?(property); !struct[property].nil? ;end

    # def runtime_image
    #   images&.all&.detect { |i| i.type == runtime_qualifier }
    # end

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

  end
end
