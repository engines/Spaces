require_relative 'status'

module Blueprinting
  class Blueprint < Emissions::Emission
    include Blueprinting::Status

    class << self
      def documentation_only_keys
        [:identifier, :about]
      end
    end

    delegate(
      documentation_only_keys: :klass,
      [:blueprints, :publications] => :universe
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
