module Keys
  class Key < ::Spaces::Model

    class << self
      def features; [:tie_breaker, :domain, :username, :explanation, :token] ;end
    end

    def identifier
      identifiers.values.compact.join('::')
    end

    def identifiers
      {
        domain: domain,
        username: username,
        tie_breaker: tie_breaker
      }
    end

    def qualifier; "#{username}:#{token}@" ;end

    def tie_breaker; struct.tie_breaker ;end

    def initialize(args)
      self.struct = args[:struct] || OpenStruct.new(args)
      self.struct.identifier = self.identifier
    end

  end
end
