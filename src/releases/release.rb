require_relative 'collaboration'
require_relative 'stage'

module Releases
  class Release < Collaboration
    relation_accessor :stages

    delegate(blueprints: :universe)

    def divisions
      @divisions ||= [stages&.map(&:divisions), super].flatten.compact
    end

    def stages
      @stages ||= struct.stages&.map { |s| stage_for(s) }
    end

    def stage_for(struct)
      stage_class.new(struct: struct, release: self)
    end

    def anchor_descriptors
      @anchor_descriptors ||= struct.bindings&.map { |d| descriptor_class.new(d.descriptor) }
    end

    def blueprint_file_names_for(directory)
      blueprints.file_names_for(directory, context_identifier)
    end

    def memento_for(key)
      key == :stages ? stages.map(&:memento) : super
    end

    def stage_class; Stage ;end

  end
end
