require_relative '../universal/space'
require_relative '../git/space'
require_relative 'blueprint'

module Blueprints
  class Space < Git::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

    def import(descriptor)
      super
      import_by_json(descriptor)
    rescue Errno::ENOENT => e
      warn(error: e, descriptor: descriptor, verbosity: [:error])
    end

    def import_by_json(descriptor)
      by_json(descriptor).tap do |m|
        m.struct.descriptor = descriptor.struct
        save(m)
        import_inclusions_for(m)
        import_anchors_for(m)
      end
    rescue JSON::ParserError => e
      warn(error: e, descriptor: descriptor, verbosity: [:error])
    end

    def import_inclusions_for(model)
      unimported_blueprints_for(model, :inclusions).each { |d| import(d) }
    end

    def import_anchors_for(model)
      unimported_blueprints_for(model, :bindings).each { |d| import(d) }
    end

    def unimported_blueprints_for(model, division)
      model.descriptors_for(division).reject { |d| imported?(d) }
    end

    def ensure_space_for(descriptor)
      FileUtils.mkdir_p(path_for(descriptor))
    end

    def imported?(descriptor)
      Dir.exist?(path_for(descriptor))
    end

    def delete(descriptor)
      FileUtils.rm_rf(path_for(descriptor))
    end

    def create(descriptor)
      save(default_model_class.new(descriptor: descriptor))
    end
  end
end
