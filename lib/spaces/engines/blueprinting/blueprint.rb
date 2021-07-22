require_relative 'inflating'
require_relative 'installing'
require_relative 'resolving'
require_relative 'arenas'
require_relative 'status'

module Blueprinting
  class Blueprint < Publishing::Blueprint
    include Inflating
    include Installing
    include Resolving
    include Arenas
    include ::Blueprinting::Status

    class << self
      def documentation_only_keys
        [:identifier, :about]
      end

      def composition_class; Composition ;end
    end

    delegate(
      documentation_only_keys: :klass,
      [:blueprints, :arenas] => :universe
    )

    alias_method :blueprint, :itself

    def binder?
      keys - documentation_only_keys == [:bindings]
    end

    alias_method :organization?, :binder?

    def descriptor; @descriptor ||= blueprints.by(identifier, Spaces::Descriptor) ;end

    def transformed_for_publication; globalized ;end

  end
end
