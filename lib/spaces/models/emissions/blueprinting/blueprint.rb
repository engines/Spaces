require_relative 'arenas'
require_relative 'summary'
require_relative 'relations'

module Blueprinting
  class Blueprint < Publishing::Blueprint
    include Inflating
    include Resolving
    include Arenas
    include Summary
    include Relations

    class << self
      def documentation_only_keys
        [:identifier, :about]
      end
    end

    delegate(
      documentation_only_keys: :klass,
      [:locations, :arenas] => :universe,
      descendant_paths: :bindings
    )

    alias_method :blueprint, :itself

    def binder?
      keys - documentation_only_keys == [:bindings]
    end

    def descriptor; @descriptor ||= blueprints.by(identifier, Spaces::Descriptor) ;end

    def transformed_for_publication; globalized ;end

  end
end
