require_relative '../blueprints/blueprint'
require_relative '../universal/space'

module Blueprints
  class Space < ::Spaces::Space

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
        import_services_for(m)
      end
    end

    def import_services_for(model)
      unimported_services_for(model).each { |d| import(d) }
    end

    def unimported_services_for(model)
      model.service_descriptors&.reject { |d| imported?(d) } || []
    end

    def file_name_for(descriptor)
      ensure_subspace_for(descriptor)
      "#{subspace_path_for(descriptor)}/#{model_class.qualifier}"
    end

    def ensure_subspace_for(descriptor)
      FileUtils.mkdir_p(subspace_path_for(descriptor))
    end

    def text_file_names_for(descriptor)
      outer.text_file_names_for(descriptor)
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
