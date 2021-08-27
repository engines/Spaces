module Keys
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Key
      end
    end

    def identifiers(domain: '*', username: '*', tie_breaker: nil)
      path.glob([domain, username, tie_breaker].compact.join('/')).map do |p|
        "#{p.relative_path_from(path)}".as_compound
      end
    end

  end
end
