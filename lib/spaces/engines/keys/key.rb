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
          username: username,
          domain: domain,
          tie_breaker: tie_breaker
        }
    end

    def tie_breaker; struct.tie_breaker ;end

    def initialize(args)
      self.struct = args[:struct] || OpenStruct.new(args)
    end

  end
end
