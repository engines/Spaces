require_relative '../nodule'

module Nodules
  module R
    class R < Nodule
      Dir["#{__dir__}/scripts/*"].each { |f| require f }

    end
  end
end
