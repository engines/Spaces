require_relative 'model'
require_relative 'descriptor'

module Spaces
  class Space < Model

    class << self
      def universe
        require_relative '../../universal/space'
        @@universe ||= Universal::Space.new
      end

      def default_model_class ;end
    end

    delegate([:identifier, :universe, :default_model_class] => :klass)

    def identifiers; Dir["#{path}/*"].map { |d| d.split('/').last } ;end
    def descriptors; all.map(&:descriptor) ;end

    def all(klass = default_model_class)
      identifiers.map { |i| by(Descriptor.new(identifier: i), klass) }
    end

    def by_yaml(descriptor, klass = default_model_class)
      klass.new(descriptor: descriptor, struct: klass.from_yaml(_by(descriptor, klass, as: :yaml)))
    end

    alias_method :by, :by_yaml

    def by_json(descriptor, klass = default_model_class)
      klass.new(descriptor: descriptor, struct: open_struct_from_json(_by(descriptor, klass, as: :json)))
    end

    def save_text(model)
      _save(model, content: model.content)
      FileUtils.chmod(model.permission, writing_name_for(model)) if model.respond_to?(:permission)
    end

    def save_yaml(model)
      _save(model, content: model.emit.to_yaml, as: :yaml)
    end

    alias_method :save, :save_yaml

    def save_json(model)
      _save(model, content: model.emit.to_h_deep.to_json, as: :json)
    end

    def delete(model)
      FileUtils.rm_rf("#{path}/#{model.identifier}")
    end

    def reading_name_for(descriptor, klass = default_model_class)
      "#{path}/#{descriptor.identifier}/#{klass.qualifier}"
    end

    def writing_name_for(model)
      ensure_space_for(model)
      "#{path_for(model)}/#{model.file_name}"
    end

    def file_names_for(directory, descriptor)
      Dir["#{file_path_for(directory, descriptor)}/**/*"].reject { |f| ::File.directory?(f) }
    end

    def file_path_for(directory, context_identifier)
      [path, context_identifier, directory].compact.join('/')
    end

    def path_for(model)
      [path, model.context_identifier, model.subpath].compact.join('/')
    end

    def path; "#{universe.path}/#{identifier}" ;end

    def unresolved_names_for(directory)
      Dir[unresolved_directory_for(directory)].reject { |f| ::File.directory?(f) }
    end

    def unresolved_directory_for(directory)
      File.join(File.dirname(__FILE__), "../../unresolved/#{directory}/**/*")
    end

    def ensure_space; FileUtils.mkdir_p(path) ;end
    def ensure_space_for(model); FileUtils.mkdir_p(path_for(model)) ;end

    def encloses?(file_name); Dir.exist?(file_name) ;end

    def _by(descriptor, klass = default_model_class, as:)
      ::File.read("#{reading_name_for(descriptor, klass)}.#{as}")
    end

    def _save(model, content:, as: nil)
      model.tap do |m|
        ::File.write([writing_name_for(m), as].compact.join('.'), content)
      end
    end

  end
end
