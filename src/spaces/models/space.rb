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

    def all(klass = default_model_class)
      identifiers.map { |i| by(i, klass) }
    end

    def by_yaml(identifier, klass = default_model_class)
      klass.new(identifier: identifier, struct: klass.from_yaml(_by(identifier, klass, as: :yaml)))
    end

    alias_method :by, :by_yaml

    def by_json(identifier, klass = default_model_class)
      klass.new(identifier: identifier, struct: open_struct_from_json(_by(identifier, klass, as: :json)))
    end

    def save_text(model)
      _save(model, content: model.content)
      Pathname.new(writing_name_for(model)).chmod(model.permission) if model.respond_to?(:permission)
    end

    def save_yaml(model)
      _save(model, content: model.to_yaml, as: :yaml)
    end

    alias_method :save, :save_yaml

    def save_json(model)
      _save(model, content: model.emit.to_h_deep.to_json, as: :json)
    end

    def delete(model)
      Pathname.new("#{path}/#{model.identifier}").rmtree
    end

    def reading_name_for(identifier, klass = default_model_class)
      "#{path}/#{identifier}/#{klass.qualifier}"
    end

    def writing_name_for(model)
      ensure_space_for(model)
      "#{path_for(model)}/#{model.file_name}"
    end

    def file_names_for(directory, identifier)
      Pathname.glob("#{file_path_for(directory, identifier)}/**/*").reject { |p| p.directory? }
    end

    def file_path_for(directory, context_identifier)
      [path, context_identifier, directory].compact.join('/')
    end

    def path_for(model)
      [path, model.context_identifier, model.subpath].compact.join('/')
    end

    def path; "#{universe.path}/#{identifier}" ;end

    def ensure_space; Pathname.new(path).mkpath ;end
    def ensure_space_for(model); Pathname.new(path_for(model)).mkpath ;end

    def encloses?(file_name); Pathname.new(file_name).exist? ;end

    def _by(identifier, klass = default_model_class, as:)
      Pathname.new("#{reading_name_for(identifier, klass)}.#{as}").read
    end

    def _save(model, content:, as: nil)
      model.tap do |m|
        Pathname.new([writing_name_for(m), as].compact.join('.')).write(content)
      end
      model.identifier
    end

  end
end
