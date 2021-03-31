module Spaces
  module Reading

    def by_yaml(identifier, klass = default_model_class)
      klass.new(identifier: identifier, struct: klass.from_yaml(_by(identifier, klass, as: :yaml)))
    end

    alias_method :by, :by_yaml

    def by_json(identifier, klass = default_model_class)
      klass.new(identifier: identifier, struct: open_struct_from_json(_by(identifier, klass, as: :json)))
    end

    def _by(identifier, klass = default_model_class, as:)
      Pathname.new("#{reading_name_for(identifier, klass)}.#{as}").read
    end

    def reading_name_for(identifier, klass = default_model_class)
      path.join(identifier, klass.qualifier)
    end

  end
end
