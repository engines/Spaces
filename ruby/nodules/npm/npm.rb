require_relative '../nodule'

module Nodules
  module NPM
    class NPM < Nodule

      Dir["#{__dir__}/scripts/*"].each { |f| require f }

    end
  end
end
