module Resolving
  class Resolution < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end
      def bindings_class; Divisions::Bindings ;end
    end

    delegate(
      resolutions: :universe,
      blueprints: :resolutions,
      bindings_class: :klass
    )

    relation_accessor :arena

    alias_accessor :blueprint, :predecessor

    def complete?
      all_complete?(divisions)
    end

    end

    def packing_divisions
      divisions.select { |d| d.packing_division? }.sort_by(&:composition_rank)
    end

    def empty; super.tap { |m| m.arena = arena } ;end

  end
end
