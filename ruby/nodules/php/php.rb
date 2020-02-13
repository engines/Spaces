require_relative '../nodule'

module Nodules
  module PHP
    class PHP < Nodule
      Dir["#{__dir__}/scripts/*"].each { |f| require f }

    end
  end
end
