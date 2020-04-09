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

    def by_yaml(descriptor, klass = default_model_class)
      f = File.open("#{reading_name_for(descriptor, klass)}.yaml", 'r')
      begin
        klass.new(struct: klass.from_yaml(f.read)).tap do |m|
          m.struct.descriptor = descriptor
        end
      ensure
        f.close
      end
    end

    def by_json(descriptor, klass = default_model_class)
      f = File.open("#{reading_name_for(descriptor, klass)}.json", 'r')
      begin
        klass.new(struct: open_struct_from_json(f.read)).tap do |m|
          m.struct.descriptor = descriptor
        end
      ensure
        f.close
      end
    end

    def save_text(model)
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

    def reading_name_for(descriptor, klass = default_model_class)
      "#{path}/#{descriptor.identifier}/#{klass.identifier}"
    end

    def writing_name_for(model)
      ensure_space_for(model)
      "#{path_for(model)}/#{model.file_name}"
    end

    def path_for(model)
      [path, model.context_identifier, model.subpath].compact.join('/')
    end

    def path
      "#{universe.path}/#{identifier}"
    end

    def ensure_space
      FileUtils.mkdir_p(path)
    end

    def ensure_space_for(model)
      FileUtils.mkdir_p(path_for(model))
    end

    def encloses?(file_name)
      Dir.exist?(file_name)
    end

  end
end
