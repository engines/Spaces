require_relative 'model'

module Spaces
  class Space < Model

    include Engines::Logger

    class << self
      def universe
        @@universe ||= Universe.new
      end

      def default_model_class ;end
    end

    delegate([:identifier, :universe, :default_model_class] => :klass)

    def identifiers; path.glob("*").map { |p| p.basename.to_s } ;end

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
      writing_name_for(model).chmod(model.permission) if model.respond_to?(:permission)
    end

    def save_yaml(model)
      _save(model, content: model.to_yaml, as: :yaml)
    end

    alias_method :save, :save_yaml

    def save_json(model)
      _save(model, content: model.emit.to_h_deep.to_json, as: :json)
    end

    def delete(model)
      path.join(model.identifier).rmtree
    end

    def reading_name_for(identifier, klass = default_model_class, ext = nil)
      add_ext(path.join(identifier, klass.qualifier), ext)
    end

    # FIXME: the permissions should be passed in
    def writing_name_for(model, ext = nil)
      ensure_space_for(model)

      add_ext(path_for(model).join(model.file_name), ext).tap do |path|
        logger.debug("Saving model with perms [#{perms(model)}]: #{path}")
      end
    end

    def file_names_for(directory, identifier)
      file_path_for(directory, identifier).glob("**/*").reject(&:directory?)
    end

    def file_path_for(symbol, context_identifier)
      path.join(sym_to_pathname(context_identifier), sym_to_pathname(symbol))
    end

    def path_for(model)
      path.join(model.context_identifier, model.subpath)
    end

    def path; universe.path.join(identifier); end

    def ensure_space
      path.mkpath
    end

    def ensure_space_for(model); path_for(model).mkpath ;end

    def encloses?(file_name); file_name.exist? ;end

    def _by(identifier, klass = default_model_class, as:)
      reading_name_for(identifier, klass, as).read
    end

    def _save(model, content:, as: nil)
      # FIXME: this tap doesn't do anything
      model.tap do |m|
        writing_name_for(m, as).write(content)
      end
      model.identifier
    end

    private

    def perms(model)
      sprintf "%o", model.permission if model.respond_to?(:permission)
    end

  end
end
