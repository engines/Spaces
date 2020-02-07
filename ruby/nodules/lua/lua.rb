require_relative '../nodule'

module Nodules
  class Lua < Nodule

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def identifier
        'lua'
      end
    end

  end
end
