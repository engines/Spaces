require_relative '../nodule'

module Nodules
  class NPM < Nodule

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def identifier
        'npm'
      end
    end

  end
end
