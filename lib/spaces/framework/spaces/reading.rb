module Spaces
  module Reading

    def exist_then_by(identifiable) =
      exist_then(identifiable) { by(identifiable) }

    def modified_at(identifiable, klass = default_model_class, as: default_extension)
      Pathname.new("#{reading_path_for(identifiable, klass)}.#{as}").mtime
    rescue Errno::ENOENT, NoMethodError
      raise_lost_error(identifiable)
    end

    def by_yaml(identifiable, klass = default_model_class) =
      klass.new(
        identifiable: identifiable, struct: klass.from_yaml(_by(identifiable, klass, as: :yaml))
      )

    alias_method :by, :by_yaml

    def default_extension = :yaml

    def by_json(identifiable, klass = default_model_class) =
      klass.new(
        identifiable: identifiable, struct: open_struct_from_json(_by(identifiable, klass, as: :json))
      )

    def _by(identifiable, klass = default_model_class, as:)
      Pathname.new("#{reading_path_for(identifiable, klass)}.#{as}").read
    rescue Errno::ENOENT, NoMethodError
      raise_lost_error(identifiable)
    end

  end
end
