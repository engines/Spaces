require_relative '../collaborators/collaborator'

module Domains
  class Domain < ::Collaborators::Collaborator

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@domain_step_precedence ||= { anywhere: [:variables] }
      end
    end

  end
end
