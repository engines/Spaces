module Keys
  class Key < ::Spaces::Model

    class << self
      def features = [:tie_breaker, :domain, :username, :explanation, :token]
    end

    def identifier = identifiers.values.compact.join('::')

    def identifiers =
      {
        domain: domain,
        username: username,
        tie_breaker: tie_breaker
      }

    def qualifier = "#{username}:#{token}@"

    def domain = struct.domain
    def username = struct.username
    def tie_breaker = struct.tie_breaker

    def initialize(args)
      self.struct = args[:struct] || OpenStruct.new(args)
      self.struct.identifier = self.identifier
    end

  end
end
