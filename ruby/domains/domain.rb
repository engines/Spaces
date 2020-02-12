require_relative '../products/product'
require_relative '../docker/files/collaboration'

module Domains
  class Domain < ::Products::Product
    include Docker::Files::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@domain_step_precedence ||= { anywhere: [:variables] }
      end
    end

  end
end
