module Blueprinting
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
      by_json(descriptor.identifier).tap do |m|
        m.struct.descriptor = descriptor.struct
        save(m)
        import_anchors_for(m)
      end
    rescue JSON::ParserError => e
      warn(error: e, descriptor: descriptor, verbosity: [:error])
    end

    def import_anchors_for(model)
      unimported_blueprints_for(model, :bindings).each { |d| import(d) }
    end

    def unimported_blueprints_for(model, division_identifier)
      model.descriptors_for(division_identifier).reject { |d| imported?(d) }
    end

    def imported?(descriptor)
      Pathname.new(path_for(descriptor)).exist?
    end

    def delete(identifier)
      Pathname.new(path_for(identifier)).rmtree
    end

    def create(descriptor)
      save(default_model_class.new(descriptor: descriptor))
    end
  end
end
