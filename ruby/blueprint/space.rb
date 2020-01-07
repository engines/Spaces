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

    def save(model)
      f = File.open(file_name_for(model.descriptor), 'w')
      begin
        f.write(model.to_yaml)
      ensure
        f.close
      end
    end

    def file_name_for(descriptor)
      ensure_space
      "#{path}/#{descriptor.identifier}.yaml"
    end

    def import(descriptor)
      outer.import(descriptor)
      new_for(descriptor).tap { |m| save(m) }
    end

    def model_class
      Blueprint
    end

    def outer
      universe.outer
    end
  end
end
