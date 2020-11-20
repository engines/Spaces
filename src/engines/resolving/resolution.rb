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

    alias_accessor :blueprint, :predecessor

    def emit
      super.tap { |m| m.identifier = struct.identifier }
    end

    def complete?
      all_complete?(divisions) && mandatory_divisions_present?
    end

    def bindings
      @bindings ||= bindings_class.new(emission: self, label: :bindings)
    end

    def division_for(key)
      composition.divisions[key]&.prototype(emission: self, label: key)
    end

    def auxiliary_content
      [auxiliary_content_from_divisions, auxiliary_content_from_blueprints].flatten
    end

    def auxiliary_content_from_divisions
      divisions.map { |d| d.auxiliary_content }.flatten.compact
    end

    def auxiliary_content_from_blueprints
      [itself, embeds].flatten.reverse.map do |r|
        r.auxiliary_directories.map { |d| content_in(d) }.flatten
      end.flatten
    end

    def content_in(directory)
      blueprints.file_names_for(directory, context_identifier).map do |t|
        interpolating_class.new(origin: t, directory: directory, division: self) #TODO: self here is an emission, not a division!
      end
    end

    def packing_script_file_names
      divisions.map(&:packing_script_file_names).flatten
    end

    def division_map
      @resolution_division_map ||= super.merge(
        mandatory_keys.reduce({}) do |m, k|
          m.tap { m[k] = division_for(k) }
        end.compact
      )
    end

    def keys
      [super, embeds.map(&:keys)].flatten.uniq
    end

    def maybe_with_embeds_in(division); division.with_embeds ;end

    def embeds
      struct.bindings ? bindings.embeds.map(&:resolution) : []
    end

    def binding_descriptors
      has?(:bindings) ? bindings.all.map(&:descriptor) : []
    end

    def initialize(struct: nil, blueprint: nil, identifier: nil)
      self.blueprint = blueprint
      self.struct = duplicate(struct || blueprint&.struct) || OpenStruct.new
      self.struct.identifier = identifier if identifier
    end

  end
end
