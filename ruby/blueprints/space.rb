require_relative '../universal/space'
require_relative '../git/space'
require_relative 'blueprint'

module Blueprints
  class Space < Git::Space

    alias_method :by, :by_json
    alias_method :save, :save_yaml

    def import(descriptor)
      super
      by(descriptor).tap do |m|
        save(m)
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
      Dir["#{path_for(descriptor)}/#{directory}/**/*"].reject { |f| File.directory?(f) }
    end

    def imported?(descriptor)
      Dir.exist?(path_for(descriptor))
    end

    def model_class
      Blueprint
    end
  end
end
