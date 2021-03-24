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

    def identifiers; path.glob('*').map { |p| p.basename.to_s } ;end

    def all
      identifiers.map { |i| by(i) }
    end

    def by_yaml(identifier, klass = default_model_class)
      klass.new(identifier: identifier, struct: klass.from_yaml(_by(identifier, klass, as: :yaml)))
    end

    alias_method :by, :by_yaml

    def by_json(identifier, klass = default_model_class)
      klass.new(identifier: identifier, struct: open_struct_from_json(_by(identifier, klass, as: :json)))
    end

    def save_text(model)
      _save(model, content: model.content).tap do
        set_permission_for(model) if model.respond_to?(:permission)
      end
    end

    def save_yaml(model)
      _save(model, content: model.to_yaml, as: :yaml)
    end

    alias_method :save, :save_yaml

    def save_json(model)
      _save(model, content: model.to_json, as: :json)
    end

    def exist?(model); path_for(model).exist? ;end
    def absent(array); array.reject { |r| exist?(r) } ;end

    def delete(model); path_for(model).rmtree ;end

    def reading_name_for(identifier, klass = default_model_class)
      path.join(identifier, klass.qualifier)
    end

    def writing_name_for(model)
      ensure_space_for(model)
      "#{path_for(model)}/#{model.file_name}"
    end

    def file_names_for(directory, identifier)
      file_path_for(directory, identifier).glob('**/*').reject(&:directory?)
    end

    def file_path_for(symbol, context_identifier)
      path.join("#{context_identifier}", "#{symbol}")
    end

    def path_for(model)
      path.join(model.context_identifier, model.subpath)
    end

    def path; universe.path.join(identifier); end

    def ensure_space; path.mkpath ;end

    def ensure_space_for(model); path_for(model).mkpath ;end

    def encloses?(file_name); file_name.exist? ;end

    def _by(identifier, klass = default_model_class, as:)
      Pathname.new("#{reading_name_for(identifier, klass)}.#{as}").read
    end

    def _save(model, content:, as: nil)
      model.tap do |m|
        Pathname.new([writing_name_for(m), as].compact.join('.')).write(content)
      end
      model.identifier
    end

    protected

    # FIXME: the permissions should be passed in
    def set_permission_for(model)
      writing_name_for(model).tap do |n|
        Pathname.new(n).chmod(model.permission)
        logger.debug("Saving #{n} with permissions [#{sprintf "%o", model.permission}]")
      end
    end

  end
end
