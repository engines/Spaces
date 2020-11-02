module Blueprinting
  class Space < Git::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

    alias_method :by, :by_json

    def import(descriptor)
      unless imported?(descriptor)
        super
        by(descriptor.identifier).tap { |m| import_anchors_for(m) }
      else
        by(descriptor.identifier)
      end
    rescue Errno::ENOENT => e
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
