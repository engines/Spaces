require_relative '../nodule'

module Nodules
  module Pecl
    class Pecl < Nodule
      Dir["#{__dir__}/scripts/*"].each { |f| require f }

    end
  end
end
