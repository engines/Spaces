module Resolving
  class Resolution < ::Emissions::Emission

    class << self
      def bindings_class; Divisions::Bindings ;end
    end

    delegate(
      resolutions: :universe,
      blueprints: :resolutions,
      bindings_class: :klass
    )

    alias_accessor :blueprint, :predecessor

    def complete?
      all_complete?(divisions) && mandatory_divisions_present?
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

    def division_map
      @resolution_division_map ||= super.merge(
        mandatory_keys.reduce({}) do |m, k|
          m.tap { m[k] = division_for(k) }
        end.compact
      )
    end

    def initialize(struct: nil, blueprint: nil, identifier: nil)
      unless blueprint
        super(struct: struct)
      else
        self.blueprint = blueprint
        self.struct = blueprint.struct
      end

      self.struct.identifier = identifier if identifier
    end

  end
end
