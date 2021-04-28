module Spaces
  module Reading

    def by_yaml(identifiable, klass = default_model_class)
      klass.new(identifiable: identifiable, struct: klass.from_yaml(_by(identifiable, klass, as: :yaml)))
    end

    alias_method :by, :by_yaml

    def by_json(identifiable, klass = default_model_class)
      klass.new(identifiable: identifiable, struct: open_struct_from_json(_by(identifiable, klass, as: :json)))
    end

    def _by(identifiable, klass = default_model_class, as:)
      Pathname.new("#{reading_name_for(identifiable, klass)}.#{as}").read
    rescue Errno::ENOENT, NoMethodError
      raise ::Spaces::Errors::LostInSpace, {space: self.identifier, identifier: identifiable&.identifier}
    end

    def reading_name_for(identifiable, klass = default_model_class)
      path.join(identifiable.identifier.as_path, klass.qualifier)
    end

  end
end
