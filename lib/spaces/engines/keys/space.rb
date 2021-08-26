module Keys
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Key
      end
    end

    def identifiers(username: '*', domain: '*', tie_breaker: nil)
      path.glob([username, domain, tie_breaker].compact.join('/')).map do |p|
        "#{p.relative_path_from(path)}".as_compound
      end
    end

  end
end
