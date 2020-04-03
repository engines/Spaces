require_relative '../universal/space'
require_relative '../spaces/space'
require_relative 'blueprint'

module Blueprints
  class Space < ::Spaces::Space

    def new_for(descriptor)
      model_class.new(struct: open_struct_from_json(outer.by(descriptor))).tap do |m|
        m.struct.descriptor = descriptor
      end
    end

    def import(descriptor)
      outer.import(descriptor)
      new_for(descriptor).tap do |m|
        save_yaml(m)
        import_anchors_for(m)
      end
    end

    def import_anchors_for(model)
      unimported_anchors_for(model).each { |d| import(d) }
    end

    def unimported_anchors_for(model)
      model.anchor_descriptors&.reject { |d| imported?(d) } || []
    end

    def ensure_subspace_for(descriptor)
      FileUtils.mkdir_p(path_for(descriptor))
    end

    def file_names_for(directory, descriptor)
      outer.file_names_for(directory, descriptor)
    end

    def imported?(descriptor)
      Dir.exist?(path_for(descriptor))
    end

    def model_class
      Blueprint
    end

    def outer
      universe.outer
    end
  end
end
