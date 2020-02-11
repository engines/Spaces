require_relative '../nodule'

module Nodules
  module Python
    class Python < Nodule

      Dir["#{__dir__}/scripts/*"].each { |f| require f }

      class << self
        def identifier
          'python'
        end
      end

    end
  end
end
