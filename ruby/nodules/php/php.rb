require_relative '../nodule'

module Nodules
  class PHP < Nodule

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def identifier
        'php'
      end
    end

  end
end
