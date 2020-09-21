require_relative '../emitting/emission'

module Resolutions
  class Resolution < ::Emitting::Emission

    delegate(
      mandatory_keys: :composition,
      resolution: :itself,
      resolutions: :universe,
      home_app_path: :descriptor
    )

    alias_accessor :blueprint, :predecessor

    def emit
      super.tap { |m| m.descriptor = struct.descriptor }
    end

    def auxiliary_texts
      [files_for(:injections)].flatten
    end

    def files_for(directory)
      [
        resolutions.unresolved_names_for(directory),
        blueprint_file_names_for(directory)
      ].flatten.compact.map do |t|
        text_class.new(origin: t, directory: directory, division: self)
      end
    end

    def division_map
      @resolution_division_map ||= super.merge(
        mandatory_keys.reduce({}) do |m, k|
          m.tap { m[k] = division_for(k) }
        end.compact
      )
    end

    def binding_descriptors
      has?(:bindings) ? bindings.all.map(&:descriptor) : []
    end

    def initialize(struct: nil, blueprint: nil, descriptor: nil)
      self.blueprint = blueprint
      self.struct = duplicate(struct || blueprint&.struct)
      self.struct.descriptor = self.struct.descriptor&.merge(descriptor&.emit) || descriptor&.emit
    end

  end
end
