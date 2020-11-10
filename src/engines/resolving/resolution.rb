module Resolving
  class Resolution < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end
      def bindings_class; Divisions::Bindings ;end
    end

    delegate(
      resolutions: :universe,
      bindings_class: :klass
    )

    alias_accessor :blueprint, :predecessor

    def emit
      super.tap { |m| m.identifier = struct.identifier }
    end

    def bindings
      @bindings ||= bindings_class.new(emission: self, label: :bindings)
    end

    def division_for(key)
      composition.divisions[key]&.prototype(emission: self, label: key)
    end

    def qualified_domain_name
      "#{identifier}.#{domain.name}"
    end

    def auxiliary_files
      [files_for(:injections)].flatten
    end


    def division_scripts_for(file_names)
      file_names.map do |t|
        interpolating_class.new(origin: "#{Pathname.new(__FILE__).dirname}/#{t}", directory: :scripts, division: self)
      end
    end

    def blueprint_scripts; resolution.files_for(:scripts) ;end
    def injections; resolution.files_for(:injections) ;end

    def files_for(directory)
      [
        resolutions.unresolved_names_for(directory),
        blueprint_file_names_for(directory)
      ].flatten.compact.map do |t|
        interpolating_class.new(origin: t, directory: directory, division: self)
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
