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

    def bindings
      @bindings ||= bindings_class.new(emission: self, label: :bindings)
    end

    def auxiliary_content
      [auxiliary_content_from_divisions, auxiliary_content_from_blueprints].flatten
    end

    def auxiliary_content_from_divisions
      divisions.map { |d| d.auxiliary_content }.flatten.compact
    end

    def auxiliary_content_from_blueprints
      auxiliary_directories.map { |d| content_into(d, source: itself) }.flatten
    end

    def content_into(directory, source:)
      blueprints.file_names_for(directory, source.context_identifier).map do |t|
        Interpolating::FileText.new(origin: t, directory: directory, transformable: self)
      end
    end

    def packing_divisions
      divisions.select { |d| d.packing_division? }.sort_by(&:composition_rank)
    end

  end
end
