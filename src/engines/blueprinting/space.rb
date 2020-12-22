module Blueprinting
  class Space < Git::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

    alias_method :by, :by_json
    alias_method :save, :save_json

    def import(descriptor, force: false)
      delete(descriptor) if force && imported?(descriptor)

      if imported?(descriptor)
        by(descriptor.identifier)
      else
        super(descriptor)
        by(descriptor.identifier).tap { |m| import_anchors_for(m) }
      end
    rescue Errno::ENOENT => e
      # warn(error: e, descriptor: descriptor, verbosity: [:error])
      just_print_the_error(__FILE__, __LINE__, e)
    end

    def import_anchors_for(model)
      unimported_blueprints_for(model, :bindings).each { |d| import(d) }
    end

    def unimported_blueprints_for(model, division_identifier)
      model.descriptors_for(division_identifier).reject { |d| imported?(d) }
    end

    def imported?(descriptor)
      path_for(descriptor).exist?
    end

    def delete(identifier)
      path_for(identifier).rmtree
    end

    def create(descriptor)
      save(default_model_class.new(descriptor: descriptor))
    end
  end
end
