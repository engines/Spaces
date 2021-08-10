module Spaces
  module Reading

    def modified_at(identifiable, klass = default_model_class, as: :yaml)
      Pathname.new("#{reading_name_for(identifiable, klass)}.#{as}").mtime
    rescue Errno::ENOENT, NoMethodError
      raise_lost_error(identifiable)
    end

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
      raise_lost_error(identifiable)
    end

    def reading_name_for(identifiable, klass = default_model_class)
      path.join(identifiable.identifier.as_path, klass.qualifier)
    end

    def raise_lost_error(identifiable)
      raise ::Spaces::Errors::LostInSpace, {space: self.identifier, identifier: identifiable&.identifier}
    end

  end
end
