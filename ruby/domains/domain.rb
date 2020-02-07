require_relative '../spaces/model'
require_relative '../docker/files/collaboration'

module Domains
  class Domain < ::Spaces::Model
    include Docker::File::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@domain_step_precedence ||= { anywhere: [:variables] }
      end
    end

  end
end
