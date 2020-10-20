require_relative 'model'

module Spaces
  class Space < Model

    class << self
      def universe
        @@universe ||= Universe.new
      end

      def default_model_class ;end
    end

    delegate([:identifier, :universe, :default_model_class] => :klass)

    def identifiers; Pathname.glob("#{path}/*").map { |p| "#{p.basename}" } ;end
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
      Pathname.new(writing_name_for(model)).chmod(model.permission) if model.respond_to?(:permission)
    end

    def save_yaml(model)
      _save(model, content: model.emit.to_yaml, as: :yaml)
    end

    alias_method :save, :save_yaml

    def save_json(model)
      _save(model, content: model.emit.to_h_deep.to_json, as: :json)
    end

    def delete(model)
      Pathname.new("#{path}/#{model.identifier}").rmtree
    end

    def reading_name_for(descriptor, klass = default_model_class)
      "#{path}/#{descriptor.identifier}/#{klass.qualifier}"
    end

    def writing_name_for(model)
      ensure_space_for(model)
      "#{path_for(model)}/#{model.file_name}"
    end

    def file_names_for(directory, descriptor)
      Pathname.glob("#{file_path_for(directory, descriptor)}/**/*").reject { |p| p.directory? }.map(&:to_s)
    end

    def file_path_for(directory, context_identifier)
      [path, context_identifier, directory].compact.join('/')
    end

    def path_for(model)
      [path, model.context_identifier, model.subpath].compact.join('/')
    end

    def path; "#{universe.path}/#{identifier}" ;end

    def unresolved_names_for(directory)
      Pathname.glob(unresolved_directory_for(directory)).reject { |p| p.directory? }.map(&:to_s)
    end

    def unresolved_directory_for(directory)
      Pathname.new(Pathname.new(__FILE__).dirname).join("../../unresolved/#{directory}/**/*")
    end

    def ensure_space; Pathname.new(path).mkpath ;end
    def ensure_space_for(model); Pathname.new(path_for(model)).mkpath ;end

    def encloses?(file_name); Pathname.new(file_name).exist? ;end

    def _by(descriptor, klass = default_model_class, as:)
      Pathname.new("#{reading_name_for(descriptor, klass)}.#{as}").read
    end

    def _save(model, content:, as: nil)
      model.tap do |m|
        Pathname.new([writing_name_for(m), as].compact.join('.')).write(content)
      end
    end

  end
end
