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
      f = File.open(file_name_for(descriptor), 'r')
      begin
        model_class.new(model_class.from_yaml(f.read))
      ensure
        f.close
      end
    end

    def import(descriptor)
      outer.import(descriptor)
      new_for(descriptor).tap { |m| save_yaml(m) }
    end

    def file_name_for(descriptor)
      ensure_subspace_for(descriptor)
      "#{subspace_path_for(descriptor)}/#{model_class.unqualified_identifier}.yaml"
    end

    def ensure_subspace_for(descriptor)
      FileUtils.mkdir_p(subspace_path_for(descriptor))
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
