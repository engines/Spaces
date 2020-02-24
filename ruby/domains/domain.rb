require_relative '../collaborators/collaborator'

module Domains
  class Domain < ::Collaborators::Collaborator

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@domain_step_precedence ||= { anywhere: [:variables] }
      end
    end

    def fqdn
      "#{host}.#{name}"
    end

    def host
      identifier
    end

    def name
      'current.engines.org'
    end

  end
end
