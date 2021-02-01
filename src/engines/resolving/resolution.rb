module Resolving
  class Resolution < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      resolutions: :universe,
      blueprints: :resolutions
    )

    relation_accessor :arena

    alias_accessor :blueprint, :predecessor

    def complete?
      all_complete?(divisions)
    end

    def blueprints_content
      [
        embeds.reverse.map(&:blueprints_content).flatten.compact.map do |c|
          c.tap { c.writing_identifier = context_identifier }
        end,
        super
      ].flatten.compact
    end

    def packing_divisions
      divisions.select { |d| d.packing_division? }.sort_by(&:composition_rank)
    end

    def empty; super.tap { |m| m.arena = arena } ;end

  end
end
