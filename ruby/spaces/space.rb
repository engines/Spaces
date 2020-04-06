require_relative 'model'

module Spaces
  class Space < Model

    class << self
      def universe
        require_relative '../universal/space'
        @@universe ||= Universal::Space.new
      end
    end

    delegate([:identifier, :universe] => :klass)

    def by(descriptor, klass = model_class)
      f = File.open("#{reading_name_for(descriptor, klass)}.yaml", 'r')
      begin
        klass.new(struct: klass.from_yaml(f.read))
      ensure
        f.close
      end
    end

    def save(model)
      f = File.open("#{writing_name_for(model)}", 'w')
      begin
        f.write(model.product)
        FileUtils.chmod(model.permission, writing_name_for(model)) if model.respond_to?(:permission)
      ensure
        f.close
      end
    end

    def save_yaml(model)
      f = File.open("#{writing_name_for(model)}.yaml", 'w')
      begin
        f.write(model.product.to_yaml)
      ensure
        f.close
      end
    end

    def save_json(model)
      f = File.open("#{writing_name_for(model)}.json", 'w')
      begin
        f.write(model.struct.deep_to_h.to_json)
      ensure
        f.close
      end
    end

    def save_tar(model)
      %x(cd #{path_for(model)}; tar -czf #{path_for(model)}.tgz . 2>&1)
    end

    def encloses?(file_name)
      Dir.exist?(file_name)
    end

    def reading_name_for(descriptor, klass = model_class)
      "#{path}/#{descriptor.send(klass.subspace_path_method)}/#{klass.identifier}"
    end

    def writing_name_for(model)
      ensure_subspace_for(model)
      "#{path}/#{model.file_path}"
    end

    def ensure_subspace_for(model)
      FileUtils.mkdir_p(path_for(model))
    end

    def path_for(model)
      "#{path}/#{model.subspace_path}"
    end

    def path
      "#{universe.path}/#{identifier}"
    end

    def ensure_space
      FileUtils.mkdir_p(path)
    end

  end
end
