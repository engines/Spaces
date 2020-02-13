require_relative '../nodule'

module Nodules
  module Apache
    class Apache < Nodule
      Dir["#{__dir__}/scripts/*"].each { |f| require f }

    end
  end
end
