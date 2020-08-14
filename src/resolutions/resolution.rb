require_relative 'release'

module Resolutions
  class Resolution < Release

    delegate(
      resolution: :itself,
      resolutions: :universe,
      home_app_path: :descriptor
    )

    alias_accessor :blueprint, :predecessor

    def repository_name; "#{client.identifier}/#{identifier}" ;end

    def components
      [files_for(:injections)].flatten
    end

    def files_for(directory)
      [
        resolutions.unresolved_names_for(directory),
        blueprint_file_names_for(directory)
      ].flatten.compact.map do |t|
        text_class.new(origin: t, directory: directory, context: self)
      end
    end

    def binding_descriptors
      respond_to?(:bindings) ? bindings.all.map(&:descriptor) : []
    end

    def initialize(struct: nil, blueprint: nil, descriptor: nil)
      self.blueprint = blueprint
      self.struct = duplicate(struct || blueprint&.struct)
      self.struct.descriptor = self.struct.descriptor&.merge(descriptor&.memento) || descriptor&.memento
    end

  end
end
