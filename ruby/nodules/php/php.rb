require_relative '../nodule'

module Nodule
  class PHP < Nodule

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def identifier
        'php'
      end
    end

  end
end
