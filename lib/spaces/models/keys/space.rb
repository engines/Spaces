module Keys
  class Space < ::Spaces::PathSpace

    class << self
      def default_model_class
        Key
      end
    end

    def identifiers(domain: '*', username: '*', tie_breaker: '*')
      path.glob([domain, username, tie_breaker].compact.join('/')).map do |p|
        p.directory? ? p : p.parent
      end.uniq.map do |p|
        "#{p.relative_path_from(path)}".as_compound
      end
    end

    def key_path_for(identifiable)
      Pathname.new("#{reading_path_for(identifiable)}.#{default_extension}")
    end

    protected

    def _delete(identifiable, cascade: true)
      key_path_for(identifiable).delete
      writing_path_for(identifiable).delete_if_empty
    end

  end
end
