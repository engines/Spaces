require_relative '../nodule'

module Nodules
  module Lua
    class Lua < Nodule
      Dir["#{__dir__}/scripts/*"].each { |f| require f }

    end
  end
end
