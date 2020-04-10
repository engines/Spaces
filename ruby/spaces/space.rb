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

    def identifiers
      Dir["#{path}/*"].map { |d| d.split('/').last }
    end

    def by_yaml(descriptor, klass = default_model_class)
      _by(descriptor, klass, as: :yaml) do |f|
        klass.new(struct: klass.from_yaml(f.read))
      end
    end

    def by_json(descriptor, klass = default_model_class)
      _by(descriptor, klass, as: :json) do |f|
        klass.new(struct: open_struct_from_json(f.read))
      end
    end

    def save_text(model)
      _save(model) do |f|
        f.write(model.product)
        FileUtils.chmod(model.permission, writing_name_for(model)) if model.respond_to?(:permission)
      end
    end

    def save_yaml(model)
      _save(model, as: :yaml) do |f|
        f.write(model.product.to_yaml)
      end
    end

    def save_json(model)
      _save(model, as: :json) do |f|
        f.write(model.struct.deep_to_h.to_json)
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

    def _by(descriptor, klass = default_model_class, as:, &block)
      f = File.open("#{reading_name_for(descriptor, klass)}.#{as}", 'r')
      begin
        block.call(f).tap { |m| m.struct.descriptor = descriptor }
      ensure
        f.close
      end
    end

    def _save(model, as: nil, &block)
      f = File.open([writing_name_for(model), as].compact.join('.'), 'w')
      begin
        block.call(f)
      ensure
        f.close
      end
    end

  end
end
