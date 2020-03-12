require_relative 'model'

module Spaces
  class Space < Model

    class << self
      def universe
        require_relative '../universal/space'
        @@universe ||= Universal::Space.new
      end
    end

    def by(descriptor)
      f = File.open("#{read_name_for(descriptor)}.yaml", 'r')
      begin
        model_class.new(struct: model_class.from_yaml(f.read))
      ensure
        f.close
      end
    end

    def save(model)
      f = File.open("#{write_name_for(model)}", 'w')
      begin
        f.write(model.product)
      ensure
        f.close
      end
    end

    def save_yaml(model)
      f = File.open("#{write_name_for(model)}.yaml", 'w')
      begin
        f.write(model.product.to_yaml)
      ensure
        f.close
      end
    end

    def encloses?(file_name)
      Dir.exist?(file_name)
    end

    def read_name_for(descriptor)
      "#{path}/#{descriptor.send(model_class.subspace_path_method)}/#{model_class.identifier}"
    end

    def write_name_for(model)
      ensure_subspace_for(model)
      "#{path}/#{model.file_path}"
    end

    def ensure_subspace_for(model)
      FileUtils.mkdir_p(subspace_path_for(model))
    end

    def subspace_path_for(model)
      "#{path}/#{model.subspace_path}"
    end

    def path
      "#{universe.path}/#{identifier}"
    end

    def identifier
      self.class.identifier
    end

    def ensure_space
      FileUtils.mkdir_p(path)
    end

    def universe
      self.class.universe
    end
  end
end
