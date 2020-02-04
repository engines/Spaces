require_relative '../blueprint/blueprint'
require_relative '../universal/space'

module Blueprint
  class Space < ::Spaces::Space
    # The dimensions in which blueprints exist

    def new_for(descriptor)
      model_class.new(open_struct_from_json(outer.by(descriptor))).tap do |m|
        m.struct.descriptor = descriptor
      end
    end

    def by(descriptor)
      f = File.open("#{file_name_for(descriptor)}.yaml", 'r')
      begin
        model_class.new(model_class.from_yaml(f.read))
      ensure
        f.close
      end
    end

    def import(descriptor)
      outer.import(descriptor)
      new_for(descriptor).tap do |m|
        save_yaml(m)
        import_dependencies_for(m)
      end
    end

    def import_dependencies_for(model)
      unimported_dependencies_for(model).each { |d| import(d) }
    end

    def unimported_dependencies_for(model)
      model.dependency_descriptors&.reject { |d| imported?(d) } || []
    end

    def file_name_for(descriptor)
      ensure_subspace_for(descriptor)
      "#{subspace_path_for(descriptor)}/#{model_class.unqualified_identifier}"
    end

    def ensure_subspace_for(descriptor)
      FileUtils.mkdir_p(subspace_path_for(descriptor))
    end

    def imported?(descriptor)
      Dir.exist?(subspace_path_for(descriptor))
    end

    def subspace_path_for(descriptor)
      "#{path}/#{descriptor.identifier}"
    end

    def model_class
      Blueprint
    end

    def outer
      universe.outer
    end
  end
end
